//
//  UIViewController+StrockPresentation.swift
//  CustomerProgram
//
//  Created by Spirov Peter on 17/03/2020.
//  Copyright © 2020 Salling Group A/S. All rights reserved.
//

import Foundation
import SPStorkController

extension UIViewController {
    func presentAsStork(controller: UIViewController, isClosable: Bool) {
        guard !isClosable else {
            self.presentAsStork(controller)
            return
        }
        
        let transitionDelegate = SPStorkTransitioningDelegate()
        transitionDelegate.swipeToDismissEnabled = false
        transitionDelegate.showIndicator = false
        
        controller.transitioningDelegate = transitionDelegate
        controller.modalPresentationStyle = .custom
        controller.modalPresentationCapturesStatusBarAppearance = true
        
        self.present(controller, animated: true, completion: nil)
    }
}
