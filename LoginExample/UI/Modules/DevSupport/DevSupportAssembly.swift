//
//  DevSupportAssembly.swift
//  CustomerProgram
//
//  Created by Sergey Pimenov on 16/08/2019.
//  Copyright © 2019 Salling Group A/S. All rights reserved.
//

import FieryCrucible
import Foundation

final class DevSupportAssembly: DependencyFactory {
    private let coreAssembly: CoreAssembly

    init(coreAssembly: CoreAssembly) {
        self.coreAssembly = coreAssembly
    }

    private func viewModel() -> DevSupportViewModel {
        return shared(DevSupportViewModel(
                        coreAssembly: self.coreAssembly
        ))
    }
    
    private func _viewController() -> DevSupportViewController  {
        return shared(DevSupportViewController(
            viewModel: self.viewModel()
        ))
    }
    
    private func navigationController() -> UINavigationController {
        return shared(DevSupportNavigationController(
            rootViewController: self._viewController()
        ))
    }

    func viewController() -> UIViewController {
        return shared(self.navigationController())
    }
}
