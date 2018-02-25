//
//  MenuTableViewController.swift
//  PhoneBook
//
//  Created by Kudryatzhan Arziyev on 2/22/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    let groups = ["All", "Friends", "People", "Animals"]
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTableViewCell", for: indexPath)
        
        cell.textLabel?.text = groups[indexPath.row]
        
        return cell
    }
    
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let frontVC = revealViewController().frontViewController
//        let contactsTableVC = storyboard?.instantiateViewController(withIdentifier: "ContactsTableViewController") as! ContactsTableViewController
//
//        switch indexPath.row {
//        case 0:
//            ContactController.shared.filteredContacts = []
//            contactsTableVC.isGroupSelected = false
//
//        case 1:
//            ContactController.shared.filterContacts(forGroup: .friends)
//            contactsTableVC.isGroupSelected = true
//
//        case 2:
//            ContactController.shared.filterContacts(forGroup: .people)
//            contactsTableVC.isGroupSelected = true
//
//        case 3:
//            ContactController.shared.filterContacts(forGroup: .animals)
//            contactsTableVC.isGroupSelected = true
//
//        default:
//            fatalError()
//        }
//
//        revealViewController().pushFrontViewController(frontVC, animated: true)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationNavController = segue.destination as! UINavigationController
        let contactsVC = destinationNavController.topViewController as! ContactsTableViewController
        
        if segue.identifier == "showContactsVC",
            let indexPath = tableView.indexPathForSelectedRow {
            
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

