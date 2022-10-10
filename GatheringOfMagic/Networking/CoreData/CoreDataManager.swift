//
//  CoreDataManager.swift
//  GatheringOfMagic
//
//  Created by Eduardo Oliveira on 07/10/22.
//

import CoreData
import Foundation

class CoreDataMethods {
    public func fetchRecordsForEntity(_ entity: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext, predicates: [String : String]) -> [NSManagedObject] {
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)

        // Helpers
        var result = [NSManagedObject]()
        
        for predicate in predicates {
            fetchRequest.predicate = NSPredicate(
                format: predicate.key, predicate.value
            )
        }

        do {
            // Execute Fetch Request
            let records = try managedObjectContext.fetch(fetchRequest)

            if let records = records as? [NSManagedObject] {
                result = records
            }

        } catch {
            print("\(ErrorMessages.coreDataUnableFetch.localized()) \(entity).")
        }

        return result
    }
}

