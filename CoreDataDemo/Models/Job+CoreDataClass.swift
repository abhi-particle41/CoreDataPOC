//
//  Job+CoreDataClass.swift
//  
//
//  Created by P41 on 14/12/20.
//
//

import Foundation
import CoreData
import ObjectMapper

@objc(Job)
public class Job: CoreDataBase, NSCopying {
    
    public override func mapping(map: Map) {
        job_id   <-  map["job_id"]
        name   <-  map["name"]
    }
    
    init(id: Double, name:String?, entity: NSEntityDescription, context: NSManagedObjectContext!) {
        super.init(entity: entity, insertInto: context)
        self.job_id = id
        self.name = name
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    public func copy(with zone: NSZone? = nil) -> Any {
        let copy = Job(id:job_id,
                              name:name,entity: self.entity,
                              context: self.managedObjectContext)
        return copy
    }
}
