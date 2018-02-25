//
//  AboutTableViewController.swift
//  PhoneBook
//
//  Created by Kudryatzhan Arziyev on 2/24/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import UIKit

class AboutTableViewController: UITableViewController {

    @IBOutlet weak var groupsMenuBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize navigation bar
        navigationController?.navigationBar.prefersLargeTitles = true

        // Configure navigation bar appearance
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        let font = UIFont.systemFont(ofSize: 40.0)
        navigationController?.navigationBar.largeTitleTextAttributes = [ NSAttributedStringKey.foregroundColor: UIColor(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1), NSAttributedStringKey.font: font]
        
        
        // Setup menu button
        if self.revealViewController() != nil {
            groupsMenuBarButtonItem.target = self.revealViewController()
            groupsMenuBarButtonItem.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 2
        } else { return 1}
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutTableViewCell", for: indexPath)
            
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = NSLocalizedString("Name", comment: "")
                cell.detailTextLabel?.text = Bundle.main.infoDictionary?["CFBundleName"] as? String
                
            case 1:
                cell.textLabel?.text = NSLocalizedString("Version", comment: "")
                cell.detailTextLabel?.text = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
                
            default:
                fatalError()
            }
            
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableViewCell", for: indexPath)
            
            cell.textLabel?.text = NSLocalizedString("Description", comment: "")
            
            cell.detailTextLabel?.text = NSLocalizedString("This app is a simple version for Apple's contacts. Created only for job application.", comment: "")
            cell.detailTextLabel?.numberOfLines = 0
            cell.detailTextLabel?.lineBreakMode = .byWordWrapping
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 1, indexPath.row == 0 {
            return UITableViewAutomaticDimension
        }
        
        return 44.0
    }
}
