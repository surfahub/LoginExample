//
//  RxLocalizer.swift
//  Dejourny
//
//  Created by Vladislav Tugolukov on 02.11.2020.
//  Copyright © 2020 Giacone & Associates. All rights reserved.
//

import Foundation
import RxCocoa
import RxLocalizer

extension LocalizerType {
    func rx_localize(_ string: String, arguments: CVarArg...) -> Driver<String> {
        return self.localized(string, arguments: arguments)
    }
}
