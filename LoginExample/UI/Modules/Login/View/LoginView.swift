//
//  LoginView.swift
//  Vladislav Tugolukov-Device
//
//  Created by Vladislav Tugolukov on 12/05/2020.
//  Copyright © 2020 Giacone & Associates. All rights reserved.
//

import Foundation
import UIKit
import Reusable
import RxSwift
import RxCocoa
import RxLocalizer

class LoginView: UIView, NibLoadable {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: SecureTextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var processActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var loginStateButton: UIButton!
    @IBOutlet weak var loginStateSublineView: UIView!
    
    @IBOutlet weak var loginStackView: UIStackView!
    @IBOutlet weak var registrationStateButton: UIButton!
    @IBOutlet weak var registrationStateSublineView: UIView!
    
    private var localizationStateDispose = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupLocalize()
    }
    
    func bind(state: LoginViewState) {
        self.set(error: state.error)
        self.set(state: state.state)
        self.set(inProcess: state.inProgress)
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}

private extension LoginView {
    func setupLocalize() {
        Localizer.shared
            .localized("S10_Message")
            .drive(self.messageLabel.rx.text)
            .disposed(by: self.rx.disposeBag)
        
        Localizer.shared
            .localized("S10_Login_Title")
            .drive(self.loginStateButton.rx.title())
            .disposed(by: self.rx.disposeBag)
        
        Localizer.shared
            .localized("S10_Registation_Title")
            .drive(self.registrationStateButton.rx.title())
            .disposed(by: self.rx.disposeBag)
        
        let attributes: [NSAttributedString.Key : Any] = [
            .foregroundColor: self.messageLabel.textColor!,
            .font: UIFont.systemFont(
                ofSize: self.passwordTextField.font!.pointSize,
                weight: .light
            )
        ]
        
        Localizer.shared
            .localized("S10_Email_TextField_Placeholder")
            .map {
                return .init(
                    string: $0,
                    attributes: attributes
                )
            }
            .drive(self.emailTextField.rx.attributerPlaceholder)
            .disposed(by: self.rx.disposeBag)
        
        Localizer.shared
            .localized("S10_Password_TextField_Placeholder")
            .map {
                return .init(
                    string: $0,
                    attributes: attributes
                )
            }
            .drive(self.passwordTextField.rx.attributerPlaceholder)
            .disposed(by: self.rx.disposeBag)
    }
}
    
private extension LoginView {
    func set(error: String?) {
        guard let error = error else {
            self.errorLabel.isHidden = true
            return
        }
        
        self.errorLabel.isHidden = false
        self.errorLabel.text = error
    }
}

private extension LoginView {
    func set(state: LoginViewState.State) {
        self.localizationStateDispose = .init()
        
        switch state {
        case .login:
            self.loginState()
        case .registration:
            self.registrationState()
        }
    }
    
    func loginState() {
        self.registrationStateSublineView.alpha = 0.0
        self.registrationStateButton.isSelected = false
        self.loginStateSublineView.alpha = 1.0
        self.loginStateButton.isSelected = true
        self.loginStackView.isHidden = false
        
        Localizer.shared
            .localized("S10_Login_Button")
            .drive(self.loginButton.rx.title())
            .disposed(by: self.localizationStateDispose)
    }
    
    func registrationState() {
        self.registrationStateSublineView.alpha = 1.0
        self.registrationStateButton.isSelected = true
        self.loginStateSublineView.alpha = 0.0
        self.loginStateButton.isSelected = false
        self.loginStackView.isHidden = false
        
        Localizer.shared
            .localized("S10_Registration_Button")
            .drive(self.loginButton.rx.title())
            .disposed(by: self.localizationStateDispose)
    }
}

private extension LoginView {
    func set(inProcess: Bool) {
        if inProcess {
            self.showActivityIndicator()
        } else {
            self.hideActivityIndicator()
        }
    }
    
    func showActivityIndicator() {
        self.processActivityIndicator.isHidden = false
        self.processActivityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        self.processActivityIndicator.isHidden = true
        self.processActivityIndicator.stopAnimating()
    }
}

extension Reactive where Base: LoginView {
    var state: Binder<LoginViewState> {
        return .init(self.base) { view, state in
            view.bind(state: state)
        }
    }
}
