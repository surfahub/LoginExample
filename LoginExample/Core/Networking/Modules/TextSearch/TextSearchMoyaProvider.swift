//
//  TextSearchMoyaProvider.swift
//  Hamstand-Device
//
//  Created by Сергей Глаголев on 03.06.2020.
//  Copyright © 2020 Hamstand. All rights reserved.
//

import Foundation
import Moya

enum TextSearchMoyaProvider {
    case textSearch(workspace: String, text: String )
}

extension TextSearchMoyaProvider: TargetType {
    var baseURL: URL {
        return CoreAssembly
            .shared
            .configurationAssembly()
            .configuration()
            .apiURL
    }
    
    var path: String {
        switch self {
        case .textSearch:
            return "/getWorkSpaceDeviceSearch"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .textSearch:
            return .post
        }
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case let .textSearch(workspace, searchText):
            return .requestParameters(
                parameters: [
                    "workspace": workspace,
                    "searchString": searchText
                ],
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
