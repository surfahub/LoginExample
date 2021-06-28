//
//  LoginViewAssembly.swift
//  Vladislav Tugolukov-Device
//
//  Created by Vladislav Tugolukov on 12/05/2020.
//  Copyright © 2020 Giacone & Associates. All rights reserved.
//

import Foundation
import FieryCrucible

class LoginViewAssembly: DependencyFactory {
    
    private let coreAssembly: CoreAssembly
    
    init(coreAssembly: CoreAssembly) {
        self.coreAssembly = coreAssembly
    }
    
    func viewController() -> LoginViewController {
        return shared(LoginViewController(
            viewModel: self.viewModel()
        ))
    }
    
    func viewModel() -> LoginViewModel {
        return shared(LoginViewModel(
            identityService: self.coreAssembly.servicesAssembly().identitySevice()
        ))
    }
}
