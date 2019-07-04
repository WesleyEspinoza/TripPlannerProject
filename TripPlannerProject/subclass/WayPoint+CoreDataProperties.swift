//
//  WayPoint+CoreDataProperties.swift
//  TripPlannerProject
//
//  Created by Wesley Espinoza on 7/3/19.
//  Copyright © 2019 HazeStudio. All rights reserved.
//
//

import Foundation
import CoreData


extension WayPoint {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WayPoint> {
        return NSFetchRequest<WayPoint>(entityName: "WayPoint")
    }

    @NSManaged public var lat: Double
    @NSManaged public var long: Double
    @NSManaged public var name: String?
    @NSManaged public var trip: Trip?

}
