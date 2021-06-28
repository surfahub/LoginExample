//
//  LoginViewState.swift
//  FamilyTree
//
//  Created by Vladislav Tugolukov on 21.10.2020.
//  Copyright © 2020 Giacone & Associates. All rights reserved.
//

import Foundation

struct LoginViewState: Equatable {
    enum State: Equatable {
        case login
        case registration
    }
    
    var state: State
    var inProgress: Bool
    var error: String?
}
