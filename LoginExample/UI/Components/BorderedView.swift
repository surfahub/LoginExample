//
//  BorderedView.swift
//  CustomerProgram
//
//  Created by Spirov Peter on 07/10/2019.
//  Copyright © 2019 Salling Group A/S. All rights reserved.
//

import UIKit

@IBDesignable
class BorderedView: CorneredView {
    @IBInspectable var borderColor: UIColor = .clear {
        didSet { self.colorizeView() }
    }
    
    @IBInspectable var borderWidth: Double = 1 {
        didSet { self.colorizeView() }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        self.colorizeView()
    }
    
    private func colorizeView() {
        if (self.borderColor != .clear) {
            self.layer.borderWidth = CGFloat(self.borderWidth) / UIScreen.main.scale
            self.layer.borderColor = self.borderColor.cgColor
        }
    }
}
