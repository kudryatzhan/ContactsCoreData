//
//  ContactTableViewCell.swift
//  PhoneBook
//
//  Created by Kudryatzhan Arziyev on 2/20/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var contactNameLabel: UILabel!
    
    func updateViews() {
        contactImageView.contentMode = .scaleAspectFill
        contactImageView.layer.cornerRadius = 32.0
        contactImageView.clipsToBounds = true
    }
}
