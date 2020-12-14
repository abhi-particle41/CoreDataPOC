//
//  Job+CoreDataProperties.swift
//  
//
//  Created by P41 on 14/12/20.
//
//

import Foundation
import CoreData


extension Job {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Job> {
        return NSFetchRequest<Job>(entityName: "Job")
    }

    @NSManaged public var job_id: Double
    @NSManaged public var name: String?

}
