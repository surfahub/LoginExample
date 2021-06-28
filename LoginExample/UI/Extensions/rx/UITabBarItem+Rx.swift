//
//  UITabBarItem+RxCocoa.swift
//  CustomerProgram
//
//  Created by Spirov Peter on 13/12/2019.
//  Copyright © 2019 Salling Group A/S. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UITabBarItem {
    var title: Binder<String> {
        return Binder(self.base) { tabBarItem, title in
            tabBarItem.title = title
        }
    }
}
