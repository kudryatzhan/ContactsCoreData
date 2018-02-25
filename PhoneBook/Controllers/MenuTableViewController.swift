//
//  MenuTableViewController.swift
//  PhoneBook
//
//  Created by Kudryatzhan Arziyev on 2/22/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    let groups = [NSLocalizedString("All", comment: ""),
                  NSLocalizedString("Friends", comment: ""),
                  NSLocalizedString("People", comment: ""),
                  NSLocalizedString("Animals", comment: "")]
    
    var lastSelectedCell: UITableViewCell?
    
    
    @IBAction func aboutButtonPressed(_ sender: UIButton) {
        lastSelectedCell?.textLabel?.textColor = .black
        lastSelectedCell?.backgroundColor = .white
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTableViewCell", for: indexPath)
        
        cell.textLabel?.text = groups[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lastSelectedCell?.textLabel?.textColor = .black
        lastSelectedCell?.backgroundColor = .white
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.textLabel?.textColor = .white
        cell?.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        
        lastSelectedCell = cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showContactsVC",
            let indexPath = tableView.indexPathForSelectedRow {
            
            let destinationNavController = segue.destination as! UINavigationController
            let contactsVC = destinationNavController.topViewController as! ContactsTableViewController
            
            contactsVC.menuBarButtonItem.target = self.revealViewController()
            contactsVC.menuBarButtonItem.action = #selector(SWRevealViewController.revealToggle(_:))
            contactsVC.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            contactsVC.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            
            switch indexPath.row {
            case 0:
                ContactController.shared.filteredContacts = []
                contactsVC.isGroupSelected = false
                
            case 1:
                ContactController.shared.filterContacts(forGroup: .friends)
                contactsVC.isGroupSelected = true
                
            case 2:
                ContactController.shared.filterContacts(forGroup: .people)
                contactsVC.isGroupSelected = true
                
            case 3:
                ContactController.shared.filterContacts(forGroup: .animals)
                contactsVC.isGroupSelected = true
                
            default:
                fatalError()
            }
        }
    }
}

