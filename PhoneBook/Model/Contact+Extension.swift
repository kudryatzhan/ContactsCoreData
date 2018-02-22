//
//  Contact+Extension.swift
//  PhoneBook
//
//  Created by Kudryatzhan Arziyev on 2/20/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import Foundation

enum GroupType: Int16 {
    case none, friends, people, animals
}

extension Contact {
    
    var group: GroupType {
        get {
            return GroupType(rawValue: rawGroup) ?? GroupType.none
        }
        set {
            rawGroup = newValue.rawValue
        }
    }
    
}
