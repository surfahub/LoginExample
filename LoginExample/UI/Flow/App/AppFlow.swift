//
//  RootFlow.swift
//  FamilyTree
//
//  Created by Vladislav Tugolukov on 04.10.2020.
//  Copyright © 2020 Giacone & Associates. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxFlow
import SPStorkController

class AppFlow {
    private let window: UIWindow
    private let coreAssembly: CoreAssembly
    
    init(window: UIWindow, coreAssembly: CoreAssembly) {
        self.window = window
        self.coreAssembly = coreAssembly
    }
    
    private func navigationToLoginScreen() -> FlowContributors {
        let assembly = LoginViewAssembly(coreAssembly: self.coreAssembly)
        
        self.addDevSupport(view: assembly.viewController().view)
        self.window.rootViewController = assembly.viewController()
        self.addAnimation(window: self.window)
        
        return .one(
            flowContributor: .contribute(
                withNextPresentable: LoginFlow(viewController: assembly.viewController()),
                withNextStepper: assembly.viewModel()
            )
        )
    }
    
    private func navigationToSplasScreen() -> FlowContributors {
        self.window.rootViewController = UIViewController()
        
        return .none
    }
    
    private func navigationToLoggedIn() -> FlowContributors {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .white
        let label = UILabel()
        label.text = "You are logged in"
        label.textAlignment = .center
        viewController.view.fillIn(view: label)
        
        self.addDevSupport(view: viewController.view)
        self.window.rootViewController = viewController
        self.addAnimation(window: self.window)
        
        return .none
    }
    
    private func navigationToLoginFinish() -> FlowContributors {
        _ = self.navigationToLoggedIn()
        self.window.rootViewController?.showMessage("Login Finish")
        
        return .none
    }
    
    private func navigationToRegistrationFinish() -> FlowContributors {
        _ = self.navigationToLoggedIn()
        self.window.rootViewController?.showMessage("Registration Finish")
        
        return .none
    }
    
    private func navigationToDevMenu() {
        self.window
            .rootViewController?
            .presentAsStork(
                DevSupportAssembly(coreAssembly: self.coreAssembly).viewController()
        )
    }
    
    private func addAnimation(window: UIWindow) {
        UIView.transition(
            with: window,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: nil
        )
    }
}

extension AppFlow: Flow {
    var root: Presentable {
        return self.window
    }
    
    func adapt(step: Step) -> Single<Step> {
        return .just(step)
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else {
            return .none
        }
        
        switch step {
        case .splash:
            return self.navigationToSplasScreen()
        case .login:
            return self.navigationToLoginScreen()
        case .loggedInState:
            return self.navigationToLoggedIn()
        case .loginFinish:
            return self.navigationToLoginFinish()
        case .registrationFinish:
            return self.navigationToRegistrationFinish()
        }
    }
}

private extension AppFlow {
    
    func addDevSupport(view: UIView) {
        #if DEBUG
        self.devSupportAction
            .subscribe(onNext: { [weak self] _ in
                self?.navigationToDevMenu()
            })
            .disposed(by: view.rx.disposeBag)
        
        view.addGestureRecognizer(AppFlow.devSupportGesture)
        #endif
    }
    
    private static let devSupportGesture: UIGestureRecognizer = {
        let devSupportLpgr = UILongPressGestureRecognizer(target: nil, action: nil)
        devSupportLpgr.minimumPressDuration = 1
        return devSupportLpgr
    }()
    
    private var devSupportAction: Observable<Void> {
        return Self.devSupportGesture
            .rx
            .event
            .filter { $0.state == .began }
            .map {
                $0.location(in: $0.view)
            }
            .filter {
                CGRect(
                    origin: CGPoint(x: (Self.devSupportGesture.view?.frame.width ?? 0) - 128, y: 0),
                    size: CGSize(width: 128, height: 128)
                ).contains($0)
            }
            .map { _ in () }
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
    }

}
