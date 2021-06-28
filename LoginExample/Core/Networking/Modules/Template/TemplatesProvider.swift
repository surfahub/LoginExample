//
//  TemplateProvider.swift
//  Hamstand-Device
//
//  Created by Сергей Глаголев on 25/05/2020.
//  Copyright © 2020 Hamstand. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class TemplatesProvider {
    
    private let moyaProvider: MoyaProvider<TemplatesMoyaProvider>
    
    init(plugins: [PluginType]) {
        self.moyaProvider = .init(plugins: plugins)
    }
    
    func getTempates(
        workspace: String, manufacturer: String? = nil,
        model: String? = nil, modelVersion: String? = nil,
        os: String? = nil, osVersion: String? = nil
    ) -> Single<TemplatesFilter> {
        self.moyaProvider
            .rx
            .request(.templates(
                workspace: workspace,
                manufacturer: manufacturer,
                model: model,
                modelVersion: modelVersion,
                os: os,
                osVersion: osVersion
                )
        )
            .filterSuccessfulStatusCodes()
            .map(TemplatesFilter.self)
    }
}
