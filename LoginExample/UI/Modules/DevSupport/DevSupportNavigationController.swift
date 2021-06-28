//
//  DevSupportNavigationController.swift
//  CustomerProgram
//
//  Created by Spirov Peter on 25/10/2019.
//  Copyright © 2019 Salling Group A/S. All rights reserved.
//

import Foundation
import UIKit

final class DevSupportNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .clear
        self.navigationBar.isTranslucent = true
        self.navigationBar.barTintColor = .white
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.prefersLargeTitles = true
        self.navigationBar.tintColor = #colorLiteral(red: 0.06274509804, green: 0.1921568627, blue: 0.368627451, alpha: 1)

        let style = NSMutableParagraphStyle()
        style.firstLineHeadIndent = 8
    }
}
