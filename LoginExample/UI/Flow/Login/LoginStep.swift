//
//  LoginStep.swift
//  FamilyTree
//
//  Created by Vladislav Tugolukov on 24.09.2020.
//  Copyright © 2020 Giacone & Associates. All rights reserved.
//

import RxFlow

enum LoginStep: Step {
    case loginFinish
    case registrationFinish
    case error(error: Error)
}
