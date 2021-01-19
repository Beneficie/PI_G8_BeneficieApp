//
//  DataBaseManager.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 18/01/21.
//  Copyright © 2021 Juan Souza. All rights reserved.
//

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
    func save(eventNameDB: String, eventDateDB: String) {
        let context = persistentContainer.viewContext
        let currentEventDB = CurrentEventDB(context: context)
        currentEventDB.eventNameDB = eventNameDB
        currentEventDB.eventDateDB = eventDateDB

        try? context.save()

    }

//    func edit(id: NSManagedObjectID, taskName: String, taskState: Bool) {
//            let context = persistentContainer.viewContext
//            let task = context.object(with: id) as? Task
//            task?.name = taskName
//            task?.isConcluded = taskState
//
//            try? context.save()
//        }

//        func delete(id: NSManagedObjectID) {
//            let context = persistentContainer.viewContext
//            let task = context.object(with: id)
//            context.delete(task)
//
//            try? context.save()
//        }

            
    
//// Carregar a lista de person que já está salva
//    func loadData(completion: ([Task]?) -> Void) {
//        let context = persistentContainer.viewContext
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
//        let result = try? context.fetch(request)
//        let arrayPerson = result as? [Person]
//        completion(arrayPerson)
//    }

}
