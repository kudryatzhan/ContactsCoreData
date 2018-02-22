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
        
        // Mock data
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let steveJobsImageData = UIImageJPEGRepresentation(UIImage(named: "steveJobsImage")!, 1.0),
            let elonMuskImageData = UIImageJPEGRepresentation(UIImage(named: "elonMuskImage")!, 1.0) {
            
            // Steve Jobs
            let steveJobs = Contact(context: appDelegate.persistentContainer.viewContext)
            steveJobs.name = "Steve Jobs"
            steveJobs.email = "steve.jobs@apple.com"
            steveJobs.group = .people
            steveJobs.photo = steveJobsImageData
            steveJobs.phone = "+1 111 111 11"
            
            var dateComponents = DateComponents()
            dateComponents.year = 1955
            dateComponents.month = 2
            dateComponents.day = 24
            if let date = Calendar.current.date(from: dateComponents) {
                steveJobs.birthDate = date
            }
            contacts.append(steveJobs)
            
            // Elon Musk
            let elonMusk = Contact(context: appDelegate.persistentContainer.viewContext)
            elonMusk.name = "Elon Musk"
            elonMusk.email = "elon.musk@spacex.com"
            elonMusk.group = .people
            elonMusk.photo = elonMuskImageData
            elonMusk.phone = "+2 222 222 22"
            
            dateComponents.year = 1971
            dateComponents.month = 6
            dateComponents.day = 28
            if let date = Calendar.current.date(from: dateComponents) {
                elonMusk.birthDate = date
            }
            contacts.append(elonMusk)
        }
        
    }
}
