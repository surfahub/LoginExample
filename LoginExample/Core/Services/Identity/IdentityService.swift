//
//  IdentityService.swift
//  Vladislav Tugolukov-Device
//
//  Created by Vladislav Tugolukov on 10/05/2020.
//  Copyright © 2020 Giacone & Associates. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import RxSwift
import RxRelay

class IdentityService { }

extension IdentityService {
    func create(email: String, password: String) -> Single<Void> {
        return Auth.auth()
            .rx
            .createUser(withEmail: email, password: password)
            .map { _ in return () }
            .asSingle()
    }
    
    func registration(email: String, password: String) -> Single<Void> {
        return Auth.auth()
            .rx
            .createUser(withEmail: email, password: password)
            .map { _ in return () }
            .asSingle()
    }
}

extension IdentityService {
    func login(email: String, password: String) -> Single<Void> {
        return Auth.auth()
            .rx
            .signIn(withEmail: email, password: password)
            .map { _ in return () }
            .asSingle()
    }
    
    func logout() -> Single<Void> {
        guard Auth.auth().currentUser != nil else {
            return .just(())
        }
        
        do {
            try Auth.auth().signOut()
        } catch let error {
            return .error(error)
        }
        
        return .just(())
    }
}

extension IdentityService {
    public var isLoggedIn: Bool {
        get { return self.userId != nil }
    }
    
    public var userId: String? {
        get { return Auth.auth().currentUser?.uid }
    }
    
    func listenUserId() -> Observable<String?> {
        return Observable.merge(
            .just(Auth.auth().currentUser),
            Auth.auth().rx.idTokenDidChange
        ).map { $0?.uid }
    }
    
    func listenIsLoggedIn() -> Observable<Bool> {
        return self.listenUserId()
            .map { $0 != nil}
    }
}

extension IdentityService: ReactiveCompatible { }
