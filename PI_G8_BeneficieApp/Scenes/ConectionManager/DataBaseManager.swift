//
//  DataBaseManager.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 18/01/21.
// /Users/dominiquenb/Library/Developer/CoreSimulator/Devices/2C1F55BE-5A10-4AD8-B804-D91DA4C5AFE6/data/Containers/Data/Application/7982D1E0-4E83-423E-AA87-68C66708E15F/Library/Application Support/

import CoreData
import UIKit

class DataBaseManager {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func loadData(completion: ([CurrentEventDB]?) -> Void) {
            let context = persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CurrentEventDB")
            let result = try? context.fetch(request)
            let arrayCurrentEventDB = result as? [CurrentEventDB]
            completion(arrayCurrentEventDB)
    }
//
//    // Salvar novo objeto
    func save(eventName: String, eventDate: String, eventAddress: String, eventDescription: String, eventSubgroup: String) {
        let context = persistentContainer.viewContext
        let currentEventDB = CurrentEventDB(context: context)
        currentEventDB.eventNameDB = eventName
        currentEventDB.eventDateDB = eventDate
        currentEventDB.eventAddressDB = eventAddress
        currentEventDB.eventSubgroupDB = eventSubgroup
        currentEventDB.eventDescriptionDB = eventDescription

        try? context.save()

    }

    func edit(id: NSManagedObjectID, eventNameDB: String, eventDateDB: String) {
            let context = persistentContainer.viewContext
            let currentEventDB = context.object(with: id) as? CurrentEventDB
            currentEventDB?.eventNameDB = eventNameDB
            currentEventDB?.eventDateDB = eventDateDB

            try? context.save()
        }

        func delete(id: NSManagedObjectID) {
            let context = persistentContainer.viewContext
            let currentEventDB = context.object(with: id)
            context.delete(currentEventDB)

            try? context.save()
        }
}
