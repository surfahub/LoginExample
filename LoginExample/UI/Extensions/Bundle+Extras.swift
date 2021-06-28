//
//  Bundle+Extras.swift
//  CustomerProgram
//
//  Created by Sergey Pimenov on 12/08/2019.
//  Copyright © 2019 Salling Group A/S. All rights reserved.
//

import Foundation

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }

    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }

    var applicationName: String? {
        return Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
    }
}
