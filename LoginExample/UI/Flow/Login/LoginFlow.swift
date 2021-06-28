//
//  LoginFlow.swift
//  FamilyTree
//
//  Created by Vladislav Tugolukov on 04.10.2020.
//  Copyright © 2020 Giacone & Associates. All rights reserved.
//

import Foundation

import RxSwift
import RxFlow

class LoginFlow {
    
    private weak var viewController: LoginViewController!
    
    init(viewController: LoginViewController) {
        self.viewController = viewController
    }
    
    private func loginFinish() -> FlowContributors {
        return .end(forwardToParentFlowWithStep: AppStep.loginFinish)
    }
    
    private func registrationFinish() -> FlowContributors {
        return .end(forwardToParentFlowWithStep: AppStep.registrationFinish)
    }
}

extension LoginFlow: Flow {
    var root: Presentable {
        return self.viewController
    }
    
    func adapt(step: Step) -> Single<Step> {
        return .just(step)
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? LoginStep else {
            return .none
        }
        
        switch step {
        case .loginFinish:
            return self.loginFinish()
        case .registrationFinish:
            return self.registrationFinish()
        case .error(let error):
            return self.navigateToError(error: error)
        }
    }
}

extension LoginFlow: ErrorableFlow {    
    var errorPresentableViewController: UIViewController {
        return self.viewController
    }
}
