//
//  RootStep.swift
//  FamilyTree
//
//  Created by Vladislav Tugolukov on 04.10.2020.
//  Copyright © 2020 Giacone & Associates. All rights reserved.
//

import RxFlow

enum AppStep: Equatable, Step {
    case splash
    
    case login
    case loginFinish
    case registrationFinish
    
    case loggedInState
}

