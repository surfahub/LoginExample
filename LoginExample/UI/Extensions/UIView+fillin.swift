//
//  UIView+fillin.swift
//  CustomerProgram
//
//  Created by Spirov Peter on 14/09/2019.
//  Copyright © 2019 Salling Group A/S. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func fillIn(view: UIView) {
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false

        let constrains = [view.leftAnchor.constraint(equalTo: self.leftAnchor),
                          view.rightAnchor.constraint(equalTo: self.rightAnchor),
                          view.topAnchor.constraint(equalTo: self.topAnchor),
                          view.bottomAnchor.constraint(equalTo: self.bottomAnchor)]

        NSLayoutConstraint.activate(constrains)
    }

    func fillInSafeArea(view: UIView) {
        self.fillIn(view: view, layoutGuide: self.safeAreaLayoutGuide)
    }

    private func fillIn(view: UIView, layoutGuide: UILayoutGuide) {
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false

        let constrains = [view.leftAnchor.constraint(equalTo: layoutGuide.leftAnchor),
                          view.rightAnchor.constraint(equalTo: layoutGuide.rightAnchor),
                          view.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
                          view.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor)]

        NSLayoutConstraint.activate(constrains)
    }
}
