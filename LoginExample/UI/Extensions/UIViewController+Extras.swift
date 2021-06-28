//
//  UIViewController+Extras.swift
//  CustomerProgram
//
//  Created by Sergey Pimenov on 26/07/2019.
//  Copyright © 2019 Salling Group A/S. All rights reserved.
//

import Foundation
import UIKit
import RxLocalizer
import RxSwift
import RxRelay
import RxCocoa
import RxGesture

extension UIViewController {
    static func topPresentedViewController(_ viewController: UIViewController) -> UIViewController {
        if let presentedViewController = viewController.presentedViewController {
            return UIViewController.topPresentedViewController(presentedViewController)
        }

        if let viewController = viewController as? UITabBarController,
            let selectedViewController = viewController.selectedViewController {
            return UIViewController.topPresentedViewController(selectedViewController)
        }

        if let viewController = viewController as? UINavigationController,
            let topViewController = viewController.topViewController {
            return UIViewController.topPresentedViewController(topViewController)
        }

        return viewController
    }
}

// MARK: Messages
extension UIViewController {
    
}


extension UINavigationController {
    open override var childForStatusBarStyle: UIViewController? {
        return self.topViewController?.childForStatusBarStyle ?? self.topViewController
    }
}

extension UITabBarController {
    open override var childForStatusBarStyle: UIViewController? {
        return self.selectedViewController?.childForStatusBarStyle ?? self.selectedViewController
    }
}

extension UISplitViewController {
    open override var childForStatusBarStyle: UIViewController? {
        return self.viewControllers.last?.childForStatusBarStyle ?? self.viewControllers.last
    }
}

extension UIApplication {
    static var topNavigationViewController: UINavigationController? {
        return self.topPresentedViewController?.navigationController
    }

    static var topPresentedViewController: UIViewController? {
        return self.rootViewController.flatMap {
            UIViewController.topPresentedViewController($0)
        }
    }

    static var rootViewController: UIViewController? {
        get {
            return AppDelegate.shared.window?.rootViewController
        }

        set {
#if D_ENV || T_ENV
            self.rootViewController?
                .view
                .removeGestureRecognizer(self.devSupportGesture)
#endif
            
            let window = UIWindow(frame: UIScreen.main.bounds)
            AppDelegate.shared.window = window
            window.rootViewController = newValue
            window.makeKeyAndVisible()
            
#if D_ENV || T_ENV
            newValue?.view
                .addGestureRecognizer(self.devSupportGesture)
#endif
        }
    }
    
    private static let devSupportGesture: UIGestureRecognizer = {
        let devSupportLpgr = UILongPressGestureRecognizer(target: nil, action: nil)
        devSupportLpgr.minimumPressDuration = 1

        devSupportLpgr.rx
            .event
            .filter { $0.state == .began }
            .map {
                $0.location(in: $0.view)
            }
            .filter {
                CGRect(
                    origin: CGPoint(x: (devSupportLpgr.view?.frame.width ?? 0) - 128, y: 0),
                    size: CGSize(width: 128, height: 128)
                ).contains($0)
            }
            .subscribe(onNext: { _ in
                
            })
            .disposed(by: devSupportLpgr.rx.disposeBag)
        
        return devSupportLpgr
    }()
}

extension UIViewController {
    enum LifeCycle {
        case inited
        case viewDidLoad
        case viewWillAppear
        case viewDidAppear
        case viewWillDisappear
        case viewDidDisappear
        
        case willMoveToParentViewController(controller: UIViewController?)
        case didMoveToParentViewController(controller: UIViewController?)
    }
}

extension Reactive where Base: UIViewController {
    
    var lifeCycle: BehaviorRelay<Base.LifeCycle> {
        let action = BehaviorRelay<Base.LifeCycle>(value: .inited)
        
        self.viewDidLoad
            .map { _ in Base.LifeCycle.viewDidLoad }
            .bind(to: action)
            .disposed(by: self.disposeBag)
        
        self.viewWillAppear
            .map { _ in Base.LifeCycle.viewWillAppear }
            .bind(to: action)
            .disposed(by: self.disposeBag)
        
        self.viewDidAppear
            .map { _ in Base.LifeCycle.viewDidAppear }
            .bind(to: action)
            .disposed(by: self.disposeBag)
        
        self.viewWillDisappear
            .map { _ in Base.LifeCycle.viewWillDisappear }
            .bind(to: action)
            .disposed(by: self.disposeBag)
        
        self.viewDidDisappear
            .map { _ in Base.LifeCycle.viewDidDisappear }
            .bind(to: action)
            .disposed(by: self.disposeBag)
        
        self.willMoveToParentViewController
            .map { controller in Base.LifeCycle.willMoveToParentViewController(
                controller: controller
                )
        }
            .bind(to: action)
            .disposed(by: self.disposeBag)

        self.didMoveToParentViewController
            .map { controller in Base.LifeCycle.didMoveToParentViewController(
                controller: controller
                )
        }
            .bind(to: action)
            .disposed(by: self.disposeBag)
        
        return action
    }
    
    var viewDidLoad: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.viewDidLoad)).map { _ in }
        return ControlEvent(events: source)
    }

    var viewWillAppear: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewWillAppear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
    var viewDidAppear: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewDidAppear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }

    var viewWillDisappear: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewWillDisappear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
    var viewDidDisappear: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewDidDisappear)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }

    var viewWillLayoutSubviews: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.viewWillLayoutSubviews)).map { _ in }
        return ControlEvent(events: source)
    }
    var viewDidLayoutSubviews: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.viewDidLayoutSubviews)).map { _ in }
        return ControlEvent(events: source)
    }

    var willMoveToParentViewController: ControlEvent<UIViewController?> {
        let source = self.methodInvoked(#selector(Base.willMove)).map { $0.first as? UIViewController }
        return ControlEvent(events: source)
    }
    var didMoveToParentViewController: ControlEvent<UIViewController?> {
        let source = self.methodInvoked(#selector(Base.didMove)).map { $0.first as? UIViewController }
        return ControlEvent(events: source)
    }

    var didReceiveMemoryWarning: ControlEvent<Void> {
        let source = self.methodInvoked(#selector(Base.didReceiveMemoryWarning)).map { _ in }
        return ControlEvent(events: source)
    }

    /// Rx observable, triggered when the ViewController appearance state changes (true if the View is being displayed, false otherwise)
    var isVisible: Observable<Bool> {
        let viewDidAppearObservable = self.base.rx.viewDidAppear.map { _ in true }
        let viewWillDisappearObservable = self.base.rx.viewWillDisappear.map { _ in false }
        return Observable<Bool>.merge(viewDidAppearObservable, viewWillDisappearObservable)
    }

    /// Rx observable, triggered when the ViewController is being dismissed
    var isDismissing: ControlEvent<Bool> {
        let source = self.sentMessage(#selector(Base.dismiss)).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
}
