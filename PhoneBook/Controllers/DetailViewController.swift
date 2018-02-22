//
//  DetailViewController.swift
//  PhoneBook
//
//  Created by Kudryatzhan Arziyev on 2/21/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var contactNameLabel: UILabel!
    
    
    // MARK: - Properties
    var contact: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // photo setup
        // FIXME: - Fix forced unwrapping later
        contactImageView.layer.cornerRadius = 64.0
        contactImageView.clipsToBounds = true
        contactImageView.contentMode = .scaleAspectFill
        contactImageView.image = UIImage(data: contact!.photo!)
        
        // nameLabel setup
        contactNameLabel.text = contact?.name
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PhoneNumberTableViewCell.self), for: indexPath) as! PhoneNumberTableViewCell
            
            cell.phoneNumbeLabel.text = contact?.phone
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EmailTableViewCell.self), for: indexPath) as! EmailTableViewCell
            cell.emailLabel.text = contact?.email
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BirthdayTableViewCell.self), for: indexPath) as! BirthdayTableViewCell
            //FIXME: - FIX forced unwrapping later
            cell.birthdayLabel.text = dateFormatter.string(from: contact!.birthDate!)
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GroupTableViewCell.self), for: indexPath) as! GroupTableViewCell

            cell.setupViews()
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}
