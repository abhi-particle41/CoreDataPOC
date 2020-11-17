//
//  SchoolTest+CoreDataClass.swift
//  CoreDataDemo
//
//  Created by P41 on 12/11/20.
//
//

import Foundation
import CoreData
import ObjectMapper


class SchoolTest: NSManagedObject, NSCopying, Mappable {
    required init?(map: Map) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let enty = NSEntityDescription.entity(forEntityName: "SchoolTest", in: context)
        super.init(entity: enty!, insertInto: context)
    }
    
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    @NSManaged  var job_id: Double
    @NSManaged  var name: String?
    
    
    func mapping(map: Map) { 
        job_id   <-  map["job_id"]
        name   <-  map["name"]
    }
    
     init(id: Double, name:String?, entity: NSEntityDescription, context: NSManagedObjectContext!) {
        super.init(entity: entity, insertInto: context)
        self.job_id = id
        self.name = name
    }
    
     func copy(with zone: NSZone? = nil) -> Any {
        let copy = SchoolTest(id:job_id,
                              name:name,entity: self.entity,
                       context: self.managedObjectContext)
        return copy
    }
    
    func save() {
        do {
            try self.managedObjectContext!.save()
        }catch {
            let error : NSError? = error as NSError
            NSLog("Unresolved error \(error?.localizedDescription ?? "Failed with unknown error"), \(error?.userInfo)")
            abort()
        }
    }
    
}
