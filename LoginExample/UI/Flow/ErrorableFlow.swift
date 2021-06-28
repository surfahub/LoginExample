//
//  ErrorableFlow.swift
//  Dejourny
//
//  Created by Vladislav Tugolukov on 08.12.2020.
//  Copyright © 2020 Giacone & Associates. All rights reserved.
//

import Foundation
import UIKit
import RxFlow

protocol ErrorableFlow {
    var errorPresentableViewController: UIViewController { get }
    
    func navigateToError(message: String) -> FlowContributors
    func navigateToError(error: Error) -> FlowContributors
}

extension ErrorableFlow {
    func navigateToError(message: String) -> FlowContributors {
        self.errorPresentableViewController.showMessage(message)
        return .none
    }
    
    func navigateToError(error: Error) -> FlowContributors {
        return self.navigateToError(
            message: error.localizedDescription
        )
    }
}
