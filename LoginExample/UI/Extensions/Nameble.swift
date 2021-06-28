//
//  Nameble.swift
//  CustomerProgram
//
//  Created by Spirov Peter on 14/09/2019.
//  Copyright © 2019 Salling Group A/S. All rights reserved.
//

import Foundation
import RxLocalizer

protocol Nameble: AnyObject {
    static var name: String { get }
    static var targetName: String { get }
}

extension UIView: Nameble {
    
}

extension Nameble {
    static var name: String {
        return String(describing: self)
    }
    
    static var targetName: String {
        return Localizer.shared.localized("TargetName") + self.name
    }

}
