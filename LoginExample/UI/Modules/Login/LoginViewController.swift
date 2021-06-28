//
//  LoginViewController.swift
//  Vladislav Tugolukov-Device
//
//  Created by Vladislav Tugolukov on 12/05/2020.
//  Copyright © 2020 Giacone & Associates. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    private lazy var loginView = LoginView.loadFromNib()
    private let viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupAction()
        self.setupDataSource()
    }
    
    func presentVerificationData(error: String) {
        self.loginView.errorLabel.text = error
        self.loginView.errorLabel.isHidden = false
    }
    
    private func setupAction() {
        self.addConfirmAction()
        self.addStateSelectionAction()
    }
    
    private func addConfirmAction() {
        self.loginView
            .emailTextField
            .rx
            .editingDidEndOnExit
            .bind(to: self.loginView.passwordTextField.rx.becomeFirstResponder)
            .disposed(by: self.rx.disposeBag)
        
        Observable<Void>.merge(
            self.loginView.loginButton.rx.tap.asObservable()
        )
            .map { [unowned self] in
                LoginViewModel.Credential(
                    email: self.loginView.emailTextField.text ?? "",
                    password: self.loginView.passwordTextField.password ?? ""
                )
        }
            .bind(to: self.viewModel.rx.comfirmPressed)
            .disposed(by: self.rx.disposeBag)
    }
    
    private func addStateSelectionAction() {
        Observable<Void>.merge(
            self.loginView.registrationStateButton.rx.tap.asObservable(),
            self.loginView.rx.swipeGesture(.left).map { _ in () }.asObservable()
        )
            .map { _ in false}
            .bind(to: self.viewModel.rx.isLoginSelected)
            .disposed(by: self.rx.disposeBag)
        
        Observable<Void>.merge(
            self.loginView.loginStateButton.rx.tap.asObservable(),
            self.loginView.rx.swipeGesture(.right).map { _ in () }.asObservable()
        )
            .map { _ in true }
            .bind(to: self.viewModel.rx.isLoginSelected)
            .disposed(by: self.rx.disposeBag)
    }
    
    private func setupDataSource() {
        self.viewModel
            .state
            .distinctUntilChanged()
            .bind(to: self.loginView.rx.state)
            .disposed(by: self.rx.disposeBag)
        
        self.rx
            .lifeCycle
            .bind(to: self.viewModel.rx.lyfeCycle)
            .disposed(by: self.rx.disposeBag)
    }
}
