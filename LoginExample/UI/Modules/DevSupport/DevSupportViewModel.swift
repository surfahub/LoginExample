//
//  DevSupportViewModel.swift
//  CustomerProgram
//
//  Created by Sergey Pimenov on 12/08/2019.
//  Copyright © 2019 Salling Group A/S. All rights reserved.
//

import AVFoundation
import Foundation
import RxCocoa
import RxRelay
import RxSwift
import RxLocalizer

final class DevSupportViewModel {
    let state: BehaviorRelay<DevSupportState> = {
        let initialState = DevSupportState(sections: [
            DevSupportState.Section(sectionName: .user, items: [
                .user(item: .logout)
            ]),
        ])

        return BehaviorRelay<DevSupportState>(value: initialState)
    }()
    
    private let coreAssembly: CoreAssembly
    
    init(coreAssembly: CoreAssembly) {
        self.coreAssembly = coreAssembly
    }
    
    fileprivate func trigger(action: DevSupportState.Section.Item) {
        switch action {
        case let .user(item):
            switch item {
            case .logout:
                self.coreAssembly
                    .servicesAssembly()
                    .identitySevice()
                    .logout()
                    .subscribe()
                    .disposed(by: self.rx.disposeBag)
            }
        }
    }
}

extension DevSupportViewModel: ReactiveCompatible { }

extension Reactive where Base: DevSupportViewModel {
    var selected: Binder<DevSupportState.Section.Item> {
        return .init(self.base) { viewmodel, action in
            viewmodel.trigger(action: action)
        }
    }
}
