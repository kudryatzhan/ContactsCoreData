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
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return NSLocalizedString("Personal Information", comment: "Personal information header title")
        } else {
            return NSLocalizedString("Groups", comment: "Groups header title")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else {
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let contact = contact else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PhoneNumberTableViewCell.self), for: indexPath) as! PhoneNumberTableViewCell
                
                cell.phoneNumbeLabel.text = contact.phone
                return cell
                
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EmailTableViewCell.self), for: indexPath) as! EmailTableViewCell
                cell.emailLabel.text = contact.email
                return cell
                
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BirthdayTableViewCell.self), for: indexPath) as! BirthdayTableViewCell
                
                if let birthDate = contact.birthDate {
                    cell.birthdayLabel.text = dateFormatter.string(from: birthDate)
                }
                return cell
                
            default:
                fatalError()
            }
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTableViewCell", for: indexPath)
            
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = NSLocalizedString("None", comment: "")
    
            case 1:
                cell.textLabel?.text = NSLocalizedString("Friends", comment: "")
                
            case 2:
                cell.textLabel?.text = NSLocalizedString("People", comment: "")
                
            case 3:
                cell.textLabel?.text = NSLocalizedString("Animals", comment: "")
                
            default:
                fatalError()
            }
            
            if Int(contact.group.rawValue) == indexPath.row {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let contact = contact else { return }
        if indexPath.section == 1 {
            
            switch indexPath.row {
            case 0:
                ContactController.shared.change(contact: contact, toGroupType: .none)
            case 1:
                ContactController.shared.change(contact: contact, toGroupType: .friends)
            case 2:
                ContactController.shared.change(contact: contact, toGroupType: .people)
            case 3:
                ContactController.shared.change(contact: contact, toGroupType: .animals)
                
            default:
                fatalError()
            }
        }
        
        tableView.reloadData()
    }
}
