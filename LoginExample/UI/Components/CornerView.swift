//
//  CornerView.swift
//  CustomerProgram
//
//  Created by Spirov Peter on 14/09/2019.
//  Copyright © 2019 Salling Group A/S. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CorneredView: UIView {
    @IBInspectable public var cornerRadius: CGFloat = 1.0 {
        didSet { self.updateCornerRadius() }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.updateCornerRadius()
    }

    func updateCornerRadius() {
        self.layer.cornerRadius = self.cornerRadius
    }
}
