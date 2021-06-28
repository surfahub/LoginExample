//
//  LoginViewModel.swift
//  Vladislav Tugolukov-Device
//
//  Created by Vladislav Tugolukov on 12/05/2020.
//  Copyright © 2020 Giacone & Associates. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxFlow
import RxLocalizer

class LoginViewModel: Stepper {
    let steps = PublishRelay<Step>()
    let state = BehaviorRelay<LoginViewState>(
        value: .init(
            state: .login,
            inProgress: false,
            error: nil
        )
    )
    
    private let identityService: IdentityService
    private var actionDisposeBag = DisposeBag()
    
    init(identityService: IdentityService) {
        self.identityService = identityService
    }
    
    fileprivate func check(credentials: Credential) -> Bool {
        var newState = self.state.value
        
        guard credentials.email != "" else {
            newState.error = Localizer.shared.localized("S10_Email_Verification_Error")
            self.state.accept(newState)
            
            return false
        }
        
        guard credentials.password != "" else {
            newState.error = Localizer.shared.localized("S10_Password_Verification_Error")
            self.state.accept(newState)
            
            return false
        }
        
        return true
    }
    
    fileprivate func login(credentials: Credential) {
        self.actionDisposeBag = DisposeBag()
        
        self.identityService
            .login(
                email: credentials.email,
                password: credentials.password
            )
            .do(
                onSuccess: { [weak self] _ in self?.setProcess(state: false) },
                afterError: { [weak self] _ in self?.setProcess(state: false) },
                onSubscribed: { [weak self] in self?.setProcess(state: true) },
                onDispose: { [weak self] in self?.setProcess(state: false) }
            )
            .map { LoginStep.loginFinish }
            .catchError { .just(LoginStep.error(error: $0)) }
            .asObservable()
            .bind(to: self.steps)
            .disposed(by: self.actionDisposeBag)
    }
    
    fileprivate func logout() {
        self.identityService
            .logout()
            .subscribe()
            .disposed(by: self.rx.disposeBag)
    }
    
    fileprivate func registration(credentials: Credential) {
        self.actionDisposeBag = DisposeBag()
        
        self.identityService
            .registration(
                email: credentials.email,
                password: credentials.password
            )
            .asObservable()
            .do(
                onNext: { [weak self] _ in self?.setProcess(state: false) },
                afterError: { [weak self] _ in self?.setProcess(state: false) },
                onSubscribed: { [weak self] in self?.setProcess(state: true) },
                onDispose: { [weak self] in self?.setProcess(state: false) }
            )
            .map { _ in LoginStep.registrationFinish }
            .catchError{ return .just(LoginStep.error(error: $0)) }
            .bind(to: self.steps)
            .disposed(by: self.actionDisposeBag)
    }
    
    private func setProcess(state: Bool) {
        var nextStep = self.state.value
        nextStep.inProgress = state
        self.state.accept(nextStep)
    }
    
    fileprivate func stateChanged(isLoginSelected: Bool) {
        var nextStep = self.state.value
        
        if !isLoginSelected {
            nextStep.state = .registration
        } else {
            nextStep.state = .login
        }
        
        self.state.accept(nextStep)
    }

}

extension LoginViewModel: ReactiveCompatible { }

extension LoginViewModel {
    struct UserInfo {
        var firstName: String?
        var lastName: String?
        var birthDay: String?
    }
    struct Credential {
        let email: String
        let password: String
    }
    
    enum ProcessResult {
        enum Process: Equatable {
            case login
            case registration
        }
        case success(process: Process)
        case error(process: Process, error: Error)
    }
}

extension Reactive where Base: LoginViewModel {
    var lyfeCycle: Binder<UIViewController.LifeCycle> {
        return .init(self.base) { (viewModel, action) in
            switch action {
            case .viewDidAppear:
                viewModel.logout()
            default:
                break
            }
        }
    }
    var comfirmPressed: Binder<Base.Credential> {
        return .init(self.base) { viewModel, credential in
            guard viewModel.check(credentials: credential) else {
                return
            }
            
            guard viewModel.state.value.state == .login else {
                viewModel.registration(credentials: credential)
                return
            }
            
            viewModel.login(credentials: credential)
        }
    }
    
    var isLoginSelected: Binder<Bool> {
        return .init(self.base) { viewModel, isLoginSelected in
            viewModel.stateChanged(isLoginSelected: isLoginSelected)
        }
    }
}
