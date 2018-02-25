//
//  ContactController.swift
//  PhoneBook
//
//  Created by Kudryatzhan Arziyev on 2/20/18.
//  Copyright © 2018 Kudryatzhan Arziyev. All rights reserved.
//

import Foundation
import CoreData

class ContactController {
    
    // class singleton
    static let shared = ContactController()
    
    // MARK: - Properties
    var contacts = [Contact]()
    var searchResults = [Contact]()
    var filteredContacts = [Contact]()
    
    func createMockData() {
        // Mock data
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let steveJobsImageData = UIImageJPEGRepresentation(UIImage(named: "steveJobsImage")!, 1.0),
            let elonMuskImageData = UIImageJPEGRepresentation(UIImage(named: "elonMuskImage")!, 1.0),
            let scoobyDoImageData = UIImageJPEGRepresentation(UIImage(named: "scoobyDooImage")!, 1.0),
            let bastaImageData = UIImageJPEGRepresentation(UIImage(named: "bastaImage")!, 1.0),
            let jahKhalibImageData = UIImageJPEGRepresentation(UIImage(named: "jahKhalibImage")!, 1.0) {
            
            // Steve Jobs
            let steveJobs = Contact(context: appDelegate.persistentContainer.viewContext)
            steveJobs.name = NSLocalizedString("Steve Jobs", comment: "")
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
            
            // Elon Musk
            let elonMusk = Contact(context: appDelegate.persistentContainer.viewContext)
            elonMusk.name = NSLocalizedString("Elon Musk", comment: "")
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
            
            // Scooby Doo
            let scoobyDoo = Contact(context: appDelegate.persistentContainer.viewContext)
            scoobyDoo.name = NSLocalizedString("Scooby Doo", comment: "")
            scoobyDoo.email = "scooby.doo@cartoon.com"
            scoobyDoo.group = .animals
            scoobyDoo.photo = scoobyDoImageData
            scoobyDoo.phone = "N/A"
            
            dateComponents.year = 2002
            dateComponents.month = 6
            dateComponents.day = 8
            if let date = Calendar.current.date(from: dateComponents) {
                scoobyDoo.birthDate = date
            }
            
            // Basta
            let basta = Contact(context: appDelegate.persistentContainer.viewContext)
            basta.name = NSLocalizedString("Vasiliy Vakulenko", comment: "")
            basta.email = "vasiliy.vakulenko@mail.com"
            basta.group = .friends
            basta.photo = bastaImageData
            basta.phone = "+5 555 555"
            
            dateComponents.year = 1980
            dateComponents.month = 4
            dateComponents.day = 20
            if let date = Calendar.current.date(from: dateComponents) {
                basta.birthDate = date
            }
            
            // Jah Khalib
            let jahKhalib = Contact(context: appDelegate.persistentContainer.viewContext)
            jahKhalib.name = NSLocalizedString("Bakhtiyar Mamedov", comment: "")
            jahKhalib.email = "jah.khalib@mail.com"
            jahKhalib.group = .friends
            jahKhalib.photo = jahKhalibImageData
            jahKhalib.phone = "+7 777 777"
            
            dateComponents.year = 1993
            dateComponents.month = 9
            dateComponents.day = 29
            if let date = Calendar.current.date(from: dateComponents) {
                jahKhalib.birthDate = date
            }
            
            contacts = [steveJobs, elonMusk, scoobyDoo, basta, jahKhalib]
        }
    }
    
    func filterContacts(forGroup type: GroupType) {
        filteredContacts = contacts.filter { (contact) -> Bool in
            if contact.group == type {
                return true
            }
            return false
        }
    }
    
    func change(contact: Contact, toGroupType type: GroupType) {
        contact.group = type
        saveToPersistenceStore()
    }
    
    
    // Persistence
    func saveToPersistenceStore() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.saveContext()
    }
}
