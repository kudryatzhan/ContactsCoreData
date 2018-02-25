//
//  ContactsTableViewController.swift
//  PhoneBook
//
//  Created by Kudryatzhan Arziyev on 2/20/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController, UISearchResultsUpdating {
    
    // MARK: - IBOutlets
    @IBOutlet weak var menuBarButtonItem: UIBarButtonItem!
    
    // MARK: - Properties
    var searchController: UISearchController!
    var isGroupSelected = false {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup menu button
        if self.revealViewController() != nil {
            menuBarButtonItem.target = self.revealViewController()
            menuBarButtonItem.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        
        // Setup search controller
        searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.titleView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("Search contacts here", comment: "Search bar placeholder")
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.isActive {
            return ContactController.shared.searchResults.count
        } else {
            if !isGroupSelected {
                return ContactController.shared.contacts.count
            } else {
                return ContactController.shared.filteredContacts.count
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as? ContactTableViewCell else { return UITableViewCell() }
        
        var contact: Contact!
        
        if searchController.isActive {
            contact = ContactController.shared.searchResults[indexPath.row]
        } else {
            if !isGroupSelected {
                contact = ContactController.shared.contacts[indexPath.row]
            } else {
                contact = ContactController.shared.filteredContacts[indexPath.row]
            }
        }
        
        cell.updateViews()
        cell.contactNameLabel.text = contact.name
        cell.contactImageView.image = UIImage(data: contact.photo!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetailVC", sender: self)
    }
    
    // MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }
    
    // MARK: - Helper methods
    func filterContent(for searchText: String) {
        
        let arrayToFilter = !isGroupSelected ? ContactController.shared.contacts : ContactController.shared.filteredContacts
        
        ContactController.shared.searchResults = arrayToFilter.filter({ (contact) -> Bool in
            if let name = contact.name {
                let isMatch = name.localizedCaseInsensitiveContains(searchText)
                return isMatch
            }
            
            return false
        })
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailVC",
            let indexPath = tableView.indexPathForSelectedRow,
            let destinationVC = segue.destination as? DetailViewController {
            
            var contactSelected: Contact!
            if searchController.isActive {
                contactSelected = ContactController.shared.searchResults[indexPath.row]
            } else {
                if !isGroupSelected {
                    contactSelected = ContactController.shared.contacts[indexPath.row]
                } else {
                    contactSelected = ContactController.shared.filteredContacts[indexPath.row]
                }
                
            }
            destinationVC.contact = contactSelected
        }
    }
}
