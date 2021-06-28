//
//  AppDelegate+Firebase.swift
//  Vladislav Tugolukov-Device
//
//  Created by Vladislav Tugolukov on 10/05/2020.
//  Copyright © 2020 Giacone & Associates. All rights reserved.
//

import Foundation
import Firebase
import RxFirebase

extension AppDelegate {
    func setupFirebase() {
        FirebaseApp.configure()
    }
}
