//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by P41 on 12/11/20.
//

import UIKit
import ObjectMapper
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var btnSave: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if fetch() != nil {
            self.btnSave.isHidden = true
            self.btnClear.isHidden = false
        }else {
            self.btnSave.isHidden = false
            self.btnClear.isHidden = true
        }
    }

    @IBAction func btnSaveAction(_ sender: UIButton) {
        let param = ["name":"Abhishek",
                     "job_id":1234.0] as [String : Any]
        
        let schoolTest = Mapper<SchoolTest>().map(JSON: param)
        schoolTest?.save()
        self.btnSave.isHidden = true
        self.btnClear.isHidden = false
    }
    
    @IBAction func btnShowAction(_ sender: UIButton) {
        let data = self.fetch()
        
        self.lblId.text = "ID:   \(data?.job_id ?? 0.0)"
        self.lblName.text = "NAME:   \(data?.name ?? "No Name")"
    }
    
    @IBAction func btnClearAction(_ sender: UIButton) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SchoolTest")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            try context.execute(deleteRequest)
            try context.save()
            self.btnSave.isHidden = false
            self.btnClear.isHidden = true
        }
        catch {
            print("Delete data Failed")
        }
    }
    
    func fetch() -> SchoolTest? {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SchoolTest")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request) as? [SchoolTest]
            let data = result?.first
            return data
        } catch {
            print("Fetching data Failed")
            return nil
        }
    }
}

