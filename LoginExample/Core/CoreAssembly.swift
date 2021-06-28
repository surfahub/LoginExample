//
//  CoreAssembly.swift
//  CustomerProgram
//
//  Created by Sergey Pimenov on 07/08/2019.
//  Copyright © 2019 Salling Group A/S. All rights reserved.
//

import FieryCrucible
import Foundation

final class CoreAssembly: DependencyFactory {
    
    static let shared = CoreAssembly()
    
    private override init() { }

    func servicesAssembly() -> ServicesAssembly {
        return shared(.init())
    }
}
