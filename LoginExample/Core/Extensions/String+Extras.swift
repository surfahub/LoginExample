//
//  String+Extras.swift
//  CustomerProgram
//
//  Created by Sergey Pimenov on 13/08/2019.
//  Copyright © 2019 Salling Group A/S. All rights reserved.
//

import Foundation

extension String {
    func withAttributes(_ attributes: [NSAttributedString.Key: Any]? = nil) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: attributes)
    }
}
