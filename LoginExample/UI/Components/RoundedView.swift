//
//  RoundedView.swift
//  CustomerProgram
//
//  Created by Spirov Peter on 01/05/2020.
//  Copyright © 2020 Salling Group A/S. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RoundedView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()

        self.updateCornerRadius()
    }

    func updateCornerRadius() {
        self.layer.cornerRadius = min(self.bounds.width,self.bounds.height) / 2.0
    }
}
