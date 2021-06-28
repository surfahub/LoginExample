//
//  TextSearchProvider.swift
//  Hamstand-Device
//
//  Created by Сергей Глаголев on 03.06.2020.
//  Copyright © 2020 Hamstand. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class TextSearchProvider {
    
    private let moyaProvider: MoyaProvider<TextSearchMoyaProvider>
    
    init(plugins: [PluginType]) {
        self.moyaProvider = .init(plugins: plugins)
    }
    
    func getTempates( workspace: String, searchString: String ) -> Single<[String]> {
        self.moyaProvider
            .rx
            .request(.textSearch(workspace: workspace, text: searchString))
            .filterSuccessfulStatusCodes()
            .map([String].self)
    }
}
