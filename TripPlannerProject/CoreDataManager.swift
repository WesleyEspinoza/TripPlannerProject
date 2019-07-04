//
//  CoreDataManager.swift
//  TripPlannerProject
//
//  Created by Wesley Espinoza on 5/16/19.
//  Copyright © 2019 HazeStudio. All rights reserved.
//


import CoreData
import UIKit

class CoreDataManager {
    
    
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    
    static let managedContext: NSManagedObjectContext = {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        
        let persistanceContainer = appDelegate.persistentContainer
        let context = persistanceContainer.viewContext
        return context
    }()
    
    
    
    static func addTrip() -> Trip {
        
        let newTrip = NSEntityDescription.insertNewObject(forEntityName: "Trip", into: managedContext) as! Trip
        
        return newTrip
    }
    
    static func saveTrip() {
        do {
            try managedContext.save()
        } catch let error{
            print("Unable to save \(error.localizedDescription)")
        }
    }
    
    static func deleteTrip(trip: NSManagedObject) {
        managedContext.delete(trip)
        saveTrip()
    }
    
    static func getTrips() -> [Trip] {
        do {
            let fetchRequests = NSFetchRequest<Trip>(entityName: "Trip")
            let results = try managedContext.fetch(fetchRequests)
            return results
        } catch let error {
            print("Unable to get any data \(error.localizedDescription)")
            return []
        }
    }
}
