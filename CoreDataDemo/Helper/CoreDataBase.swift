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

class CoreDataBase: NSManagedObject, Mappable {
    required init?(map: Map) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let enty = NSEntityDescription.entity(forEntityName: "SchoolTest", in: context)
        super.init(entity: enty!, insertInto: context)
    }
    
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    func mapping(map: Map) {
        
    }
}
