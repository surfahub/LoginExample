//
//  ProcessableView.swift
//  Dejourny
//
//  Created by Vladislav Tugolukov on 11.12.2020.
//  Copyright © 2020 Giacone & Associates. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol ProcessableView: UIView {
    var processActivityIndicator: UIActivityIndicatorView! { get }
}

extension ProcessableView {
    func set(inProcess: Bool) {
        if inProcess {
            self.showActivityIndicator()
        } else {
            self.hideActivityIndicator()
        }
    }
    
    private func showActivityIndicator() {
        self.processActivityIndicator?.isHidden = false
        self.processActivityIndicator?.startAnimating()
    }
    
    private func hideActivityIndicator() {
        self.processActivityIndicator?.isHidden = true
        self.processActivityIndicator?.stopAnimating()
    }
}
 
extension Reactive where Base: ProcessableView {
    var state: Binder<Bool> {
        return .init(self.base) { (view, inProcess) in
            view.set(inProcess: inProcess)
        }
    }
}
