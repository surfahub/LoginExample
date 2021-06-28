//
//  UIViewController+Error.swift
//  Dejourny
//
//  Created by Vladislav Tugolukov on 02.11.2020.
//  Copyright © 2020 Giacone & Associates. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showNotImplementedMessage() {
        self.showMessage("Not implemented",title: "Warning")
    }
    
    func showErrorMessage(_ error: Error, completion: (()->())? = nil) {
        showMessage(error.localizedDescription, title: "Error", completion: completion)
    }
    
    func showMessage(_ message: String?, title: String? = nil, completion: (()->())? = nil) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in completion?() }))

        self.present(alert, animated: true)
    }
}
