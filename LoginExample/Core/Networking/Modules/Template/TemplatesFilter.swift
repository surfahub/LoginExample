//
//  TemplatesFilter.swift
//  Hamstand-Device
//
//  Created by Сергей Глаголев on 26/05/2020.
//  Copyright © 2020 Hamstand. All rights reserved.
//

import Foundation

struct TemplatesFilter: Codable, Equatable {
    let devices: [String]
    let manufacturer: [String]
    let model: [String]?
    let modelVersion: [String]?
    let os: [String]?
    let osVersion: [String]?
}
