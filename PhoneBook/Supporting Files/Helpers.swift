//
//  Helpers.swift
//  PhoneBook
//
//  Created by Kudryatzhan Arziyev on 2/21/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import Foundation

let dateFormatter: DateFormatter = {
   let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .none
    return formatter
}()
