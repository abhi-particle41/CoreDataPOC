//
//  CoreDataBase.swift
//  CoreDataDemo
//
//  Created by P41 on 17/11/20.
//

import Foundation
import CoreData
import ObjectMapper
import UIKit

public class CoreDataBase: NSManagedObject, Mappable {
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    required public init?(map: Map) {
        let enty = NSEntityDescription.entity(forEntityName: "Job", in: CoreDataBase.context)
        super.init(entity: enty!, insertInto: CoreDataBase.context)
    }
    
    @objc
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    public func mapping(map: Map) {
        print("print map called")
    }
    
    func save() {
        do {
            try self.managedObjectContext!.save()
        }catch {
            print("Unresolved error \(error.localizedDescription)")
            abort()
        }
    }
}
