//
//  AppDelegate+KeyBoard.swift
//  Vladislav Tugolukov-Device
//
//  Created by Vladislav Tugolukov on 12/05/2020.
//  Copyright © 2020 Giacone & Associates. All rights reserved.
//

import Foundation
import IQKeyboardManagerSwift

extension AppDelegate {
    func setupKeyboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.enableAutoToolbar = false
    }
}
