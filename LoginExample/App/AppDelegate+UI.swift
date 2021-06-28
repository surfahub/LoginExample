//
//  AppDelegate+UI.swift
//  Dejourny
//
//  Created by Vladislav Tugolukov on 02.11.2020.
//  Copyright © 2020 Giacone & Associates. All rights reserved.
//

import Foundation
import RxFlow
import RxLocalizer

extension AppDelegate {
    
    fileprivate static var appFlow: AppFlow!
    fileprivate static var appStepper: AppStepper!
    
    func setupUI() -> Bool{
        if self.window == nil {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.makeKeyAndVisible()
        }
        
        guard let window = self.window else {
            return false
        }
        
        Localizer.shared.changeLanguage.accept("en")
        
        self.coordinator
            .rx
            .willNavigate
            .subscribe(onNext: { (flow, step) in
                print ("will navigate to flow=\(flow) and step=\(step)")
            })
            .disposed(by: self.rx.disposeBag)
                
        self.coordinator
            .rx
            .didNavigate
            .subscribe(onNext: { (flow, step) in
                print ("did navigate to flow=\(flow) and step=\(step)")
            }
        )
            .disposed(by: self.rx.disposeBag)

        Self.appFlow = AppFlow(
            window: window,
            coreAssembly: .shared
        )

        Self.appStepper = AppStepper(
            identityService: CoreAssembly.shared.servicesAssembly().identitySevice()
        )
        
        self.coordinator.coordinate(flow: Self.appFlow, with: Self.appStepper)

        return true
    }
}
