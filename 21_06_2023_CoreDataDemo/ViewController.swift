//
//  ViewController.swift
//  21_06_2023_CoreDataDemo
//
//  Created by Vishal Jagtap on 04/09/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //addDataToCoreData()
        retriveDataFromCoreData()
    }
    
    func addDataToCoreData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let personEntity = NSEntityDescription.entity(
            forEntityName: "Person",
            in: managedContext)
        
        for i in 1...3{
            let person = NSManagedObject(
                entity: personEntity!,
                insertInto: managedContext)
            
            person.setValue("Person\(i)", forKey: "name")
            person.setValue("Person\(i)@bitcode.in", forKey: "email")
        }
        
        do{
            try managedContext.save()
        }catch let error as NSError{
            print("Error -- \(error.code)--\(error.userInfo)")
        }
    }
    
    func retriveDataFromCoreData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        do{
            let results = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            for eachResult in results{
                print(eachResult.value(forKey: "name") as! String)
                print(eachResult.value(forKey: "email") as! String)
            }
        }catch{
            print("Falied")
        }
    }
}
