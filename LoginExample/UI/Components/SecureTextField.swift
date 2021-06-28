//
//  SecureTextField.swift
//  Dejourny
//
//  Created by Vladislav Tugolukov on 22.12.2020.
//  Copyright © 2020 Giacone & Associates. All rights reserved.
//

import Foundation
import UIKit

class SecureTextField: UITextField {
    var password: String? = nil
    private lazy var _delegate = SecureTextFieldDelegate()
    
    init() {
        super.init(frame: .zero)
        
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.commonInit()
    }
    
    private func commonInit() {
        self.delegate = self._delegate
    }
}

private class SecureTextFieldDelegate: NSObject, UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let secureTextField = textField as? SecureTextField else {
            return true
        }
        
        return self.textField(secureTextField, shouldChangeCharactersIn: range, replacementString: string)
    }
    private func textField(_ textField: SecureTextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        guard string.last != "\n" else {
            return true
        }
        
        let password = textField.password as NSString?
        
        textField.password = (password ?? "").replacingCharacters(
            in: range,
            with: string
        )
        
        guard string != "" else {
            return true
        }
        
        let text = textField.text as NSString?
        textField.attributedText = text?.replacingCharacters(
            in: range,
            with: String(
                repeating: "•",
                count: string.count
            )
        ).withAttributes([
            .kern: 1.4,
            .font: UIFont.systemFont(
                ofSize: 24.0,
                weight: .bold
            )
        ])
        
        return false
    }
}
