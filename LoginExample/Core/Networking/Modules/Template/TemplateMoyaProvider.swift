//
//  TemplateMoyaProvider.swift
//  Hamstand-Device
//
//  Created by Сергей Глаголев on 25/05/2020.
//  Copyright © 2020 Hamstand. All rights reserved.
//

import Foundation
import Moya

enum TemplatesMoyaProvider {
    case templates(
        workspace: String,
        manufacturer: String?,
        model: String?,
        modelVersion: String?,
        os: String?,
        osVersion: String?
    )
}

extension TemplatesMoyaProvider: TargetType {
    var baseURL: URL {
        return CoreAssembly
            .shared
            .configurationAssembly()
            .configuration()
            .apiURL
    }
    
    var path: String {
        switch self {
        case .templates:
            return "/getWorkSpaceTemplate"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .templates:
            return .post
        }
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case let .templates(workspace, manufacturer, model, modelVersion, os, osVersion):
            
            var data = [ "workspace": workspace ]
            
            if let manufacturer = manufacturer {
                data["manufacturer"] = manufacturer
            }
            
            if let model = model {
                data["model"] = model
            }
            
            if let modelVersion = modelVersion {
                data["modelVersion"] = modelVersion
            }
            
            if let os = os {
                data["os"] = os
            }
            
            if let osVersion = osVersion {
                data["osVersion"] = osVersion
            }
            
            return .requestParameters(
                parameters: data,
                encoding: JSONEncoding()
            )
        }
    }
    
    var headers: [String : String]? {
        let dict = [
            "Content-Type": "application/json",
            "Accept": "application/json",
        ]
        
        return dict
    }
}
