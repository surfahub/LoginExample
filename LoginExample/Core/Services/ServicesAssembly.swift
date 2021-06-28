//
//  ServicesAssembly.swift
//  CustomerProgram
//
//  Created by Sergey Pimenov on 06/08/2019.
//  Copyright © 2019 Salling Group A/S. All rights reserved.
//

import FieryCrucible
import Foundation

final class ServicesAssembly: DependencyFactory {    
    func identitySevice() -> IdentityService {
        return shared(.init())
    }
}
