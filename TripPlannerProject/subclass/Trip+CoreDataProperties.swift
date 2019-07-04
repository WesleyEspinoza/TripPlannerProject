//
//  Trip+CoreDataProperties.swift
//  TripPlannerProject
//
//  Created by Wesley Espinoza on 7/3/19.
//  Copyright © 2019 HazeStudio. All rights reserved.
//
//

import Foundation
import CoreData


extension Trip {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trip> {
        return NSFetchRequest<Trip>(entityName: "Trip")
    }

    @NSManaged public var names: String?
    @NSManaged public var wayPoints: NSOrderedSet?

}

// MARK: Generated accessors for wayPoints
extension Trip {

    @objc(insertObject:inWayPointsAtIndex:)
    @NSManaged public func insertIntoWayPoints(_ value: WayPoint, at idx: Int)

    @objc(removeObjectFromWayPointsAtIndex:)
    @NSManaged public func removeFromWayPoints(at idx: Int)

    @objc(insertWayPoints:atIndexes:)
    @NSManaged public func insertIntoWayPoints(_ values: [WayPoint], at indexes: NSIndexSet)

    @objc(removeWayPointsAtIndexes:)
    @NSManaged public func removeFromWayPoints(at indexes: NSIndexSet)

    @objc(replaceObjectInWayPointsAtIndex:withObject:)
    @NSManaged public func replaceWayPoints(at idx: Int, with value: WayPoint)

    @objc(replaceWayPointsAtIndexes:withWayPoints:)
    @NSManaged public func replaceWayPoints(at indexes: NSIndexSet, with values: [WayPoint])

    @objc(addWayPointsObject:)
    @NSManaged public func addToWayPoints(_ value: WayPoint)

    @objc(removeWayPointsObject:)
    @NSManaged public func removeFromWayPoints(_ value: WayPoint)

    @objc(addWayPoints:)
    @NSManaged public func addToWayPoints(_ values: NSOrderedSet)

    @objc(removeWayPoints:)
    @NSManaged public func removeFromWayPoints(_ values: NSOrderedSet)

}
