//
//  GroupTableViewCell.swift
//  PhoneBook
//
//  Created by Kudryatzhan Arziyev on 2/21/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    @IBOutlet weak var groupSegmentedControl: UISegmentedControl!
    
    func setupViews() {
        groupSegmentedControl.setTitle("None", forSegmentAt: 0)
        groupSegmentedControl.setTitle("Friends", forSegmentAt: 1)
        groupSegmentedControl.setTitle("People", forSegmentAt: 2)
        groupSegmentedControl.setTitle("Animals", forSegmentAt: 3)
    }
}
