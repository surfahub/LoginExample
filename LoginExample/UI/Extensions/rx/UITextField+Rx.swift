//
//  UITextField+Rx.swift
//  Dejourny
//
//  Created by Vladislav Tugolukov on 04.11.2020.
//  Copyright © 2020 Giacone & Associates. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UITextField {
    var placeholder: Binder<String?> {
        return .init(self.base) { textField, placeholder in
            textField.placeholder = placeholder
        }
    }
    
    var attributerPlaceholder: Binder<NSAttributedString?> {
        return .init(self.base) { textField, placeholder in
            textField.attributedPlaceholder = placeholder
        }
    }
    
    var editingDidEndOnExit: ControlEvent<Void> {
        return self.controlEvent([.editingDidEndOnExit])
    }
    
    var becomeFirstResponder: Binder<Void> {
        return .init(self.base) { (textField, _) in
            self.base.becomeFirstResponder()
        }
    }
}
