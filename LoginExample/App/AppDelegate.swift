//
//  AppDelegate.swift
//  Vladislav Tugolukov-Device
//
//  Created by Vladislav Tugolukov on 06/05/2020.
//  Copyright © 2020 Giacone & Associates. All rights reserved.
//

import UIKit
import RxFlow
import NSObject_Rx

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var window: UIWindow?
    var coordinator = FlowCoordinator()
    let coreAssembly = CoreAssembly.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.setupKeyboard()
        self.setupFirebase()
        self.setupDataSource()
                
        return self.setupUI()
    }
    
}

