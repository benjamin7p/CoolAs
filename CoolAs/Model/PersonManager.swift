//
//  PersonManager.swift
//  CoolAs
//
//  Created by Benjamin Poulsen PRO on 1/15/19.
//  Copyright © 2019 Benjamin Poulsen PRO. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class PersonManager {
    
    let context: NSManagedObjectContext
    let appDelegate: AppDelegate
    
    init(appDelegate: AppDelegate) {
        self.context = appDelegate.persistentContainer.viewContext
        self.appDelegate = appDelegate
    }
    
    func fetchData() -> [Person] {
        let request = NSFetchRequest<Person>(entityName: "Person")
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
    
    func create(personName: String, emojiName: String) -> Person {
        let person = Person(context: appDelegate.persistentContainer.viewContext)
        person.name = personName
        let emoji = Emoji(context: appDelegate.persistentContainer.viewContext)
        emoji.emojiName = emojiName
        person.emoji = emoji
        return person
    }
    
    func save() {
        appDelegate.saveContext()
    }
    
//    func delete(personToDelete: Person) {
//        context.delete
//        
//    }
    
    func delete(personToDelete: Person) {
//        var _ = Person(context: appDelegate.persistentContainer.viewContext)
        appDelegate.persistentContainer.viewContext.delete(personToDelete)
    }
    
}
