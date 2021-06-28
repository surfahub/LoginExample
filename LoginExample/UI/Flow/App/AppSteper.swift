//
//  AppSteper.swift
//  FamilyTree
//
//  Created by Vladislav Tugolukov on 04.10.2020.
//  Copyright © 2020 Giacone & Associates. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxFlow

class AppStepper {
    let steps = PublishRelay<Step>()
    private let identityService: IdentityService
    private var disposeBag = DisposeBag()

    init(identityService: IdentityService) {
        self.identityService = identityService
    }
    
    private func currentStep(isLogin: Bool) -> AppStep {
        guard isLogin else {
            return .login
        }
        
        return .loggedInState
    }
}

extension AppStepper: ReactiveCompatible { }

extension AppStepper: Stepper {
    
    var initialStep: Step {
        return self.currentStep(
            isLogin: self.identityService.isLoggedIn
        )
    }

    func readyToEmitSteps() {
        self.disposeBag = .init()
        
        self.identityService
            .listenIsLoggedIn()
            .filter { $0 == false }
            .map { [unowned self] in self.currentStep(isLogin: $0) }
            .bind(to: self.steps)
            .disposed(by: self.disposeBag)
    }
}
