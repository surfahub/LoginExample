//
//  DevSupportState.swift
//  CustomerProgram
//
//  Created by Sergey Pimenov on 12/08/2019.
//  Copyright © 2019 Salling Group A/S. All rights reserved.
//

import Foundation
import RxDataSources

struct DevSupportState {
    struct Section: Equatable {
        enum ItemSectionName: String, Equatable {
            case user
        }

        enum Item: Equatable {
            enum UserCell: String, Equatable {
                case logout
            }

            case user(item: UserCell)
        }

        let items: [Item]
        let sectionName: ItemSectionName
    }

    let sections: [Section]
}

extension DevSupportState.Section: IdentifiableType, SectionModelType {
    typealias Identity = String

    init(sectionName: ItemSectionName, items: [Item]) {
        self.items = items
        self.sectionName = sectionName
    }

    init(original: DevSupportState.Section, items: [Item]) {
        self.sectionName = original.sectionName
        self.items = items
    }

    var identity: Identity {
        return self.sectionName.rawValue
    }
}

extension DevSupportState.Section.Item: IdentifiableType {
    typealias Identity = String

    var identity: Identity {
        switch self {
        case let .user(item):
            return item.rawValue
        }
    }
}
