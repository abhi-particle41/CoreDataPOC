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
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var btnSave: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func btnSaveAction(_ sender: UIButton) {
        let number = Double(random(digits: 4)) ?? 0
        let param = ["name":"Abhishek",
                     "job_id":number] as [String : Any]
        
        let job = Mapper<Job>().map(JSON: param)
        job?.save()
        self.tableView.reloadData()
    }
    
    @IBAction func btnClearAction(_ sender: UIButton) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Job")
        self.deleteData(withRequest: fetchRequest)
        self.tableView.reloadData()
    }
    
    func fetch() -> [Job]? {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Job")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request) as? [Job]
            return result
        } catch {
            print("Fetching data Failed")
            return nil
        }
    }
    
    func deleteData(withRequest request: NSFetchRequest<NSFetchRequestResult>) {
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            try context.execute(deleteRequest)
            try context.save()
        }
        catch {
            print("Delete data Failed")
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetch()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableCell
        let data = self.fetch()?[indexPath.row]
        cell.lblId.text = "ID:   \(data?.job_id ?? 0.0)"
        cell.txtName.text = "NAME:   \(data?.name ?? "No Name")"
        cell.txtName.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let data = self.fetch()?[indexPath.row]
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Job")
            request.predicate = NSPredicate(format:"job_id = %f", data?.job_id ?? 0)
            self.deleteData(withRequest: request)
            self.tableView.reloadData()
        }
    }
    
    func random(digits:Int) -> String {
        var number = String()
        for _ in 1...digits {
           number += "\(Int.random(in: 1...9))"
        }
        return number
    }
}

class TableCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var lblId: UITextField!
    @IBOutlet weak var txtName: UITextField!
    
    @IBAction func editSaveAction(_ sender: UIButton) {
        self.txtName.isUserInteractionEnabled = !self.txtName.isUserInteractionEnabled
        if sender.titleLabel?.text == "Edit" {
            self.txtName.becomeFirstResponder()
            sender.setTitle("Save", for: .normal)
        }else {
            if self.txtName.text!.isEmpty {
                self.txtName.becomeFirstResponder()
                return
            }
            let data = self.fetch()
            data?[self.txtName.tag].name = self.txtName.text
            do {
                try CoreDataBase.context.save()
            }
            catch {
                print(error.localizedDescription)
            }
            sender.setTitle("Edit", for: .normal)
        }
    }
    
    func fetch() -> [Job]? {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Job")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request) as? [Job]
            return result
        } catch {
            print("Fetching data Failed")
            return nil
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
}
