//
//  LogoutableFlow.swift
//  Dejourny
//
//  Created by Vladislav Tugolukov on 09.12.2020.
//  Copyright © 2020 Giacone & Associates. All rights reserved.
//

import Foundation
import UIKit
import RxFlow

protocol LogoutableFlow {
    associatedtype ViewController
    
    var viewController: ViewController { get }
    
    func navigateToLogout() -> FlowContributors
}

extension LogoutableFlow where ViewController: UIViewController {
    func navigateToLogout() -> FlowContributors {
        self.viewController.removeFromParent()
        
        return .end(forwardToParentFlowWithStep: AppStep.login)
    }
}
