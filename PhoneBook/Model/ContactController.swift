//
//  ContactController.swift
//  PhoneBook
//
//  Created by Kudryatzhan Arziyev on 2/20/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import Foundation

class ContactController {
    
    // class singleton
    static let shared = ContactController()
    
    // MARK: - Properties
    var contacts = [Contact]()
    
    // Initializers
    init() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let imageData = UIImageJPEGRepresentation(UIImage(named: "steveJobsImage")!, 1.0) {
            
            let steveJobs = Contact(context: appDelegate.persistentContainer.viewContext)
            steveJobs.name = "Steve Jobs"
            steveJobs.photo = imageData
            
            contacts.append(steveJobs)
        }
        
    }
}
