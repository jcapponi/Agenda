//
//  Persistence.swift
//  Agenda
//
//  Created by Juan Capponi on 11/12/20.
//

import CoreData

struct Persistencecontroller {
    //Singleton pattern
    static let shared = Persistencecontroller()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Task")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Error info.: \(error)")
            }
        }
    }
}

