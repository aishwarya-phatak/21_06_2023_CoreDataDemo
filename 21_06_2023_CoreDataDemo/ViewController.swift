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
//        retriveDataFromCoreData()
//        updatePersonRecord()
        retriveDataFromCoreData()
        deleteAPersonRecord()
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
    
    func updatePersonRecord(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Person")
        fetchRequest.predicate = NSPredicate(
            format: "name = %@", "Person1")
        
        do{
            let fetchedResult = try managedContext.fetch(fetchRequest)
            let personObjectToBeUpdated = fetchedResult[0] as! NSManagedObject
            personObjectToBeUpdated.setValue("Prathamesh", forKey: "name")
            personObjectToBeUpdated.setValue("prathamesh@gmail.com", forKey: "email")
            do{
                try managedContext.save()
            }catch{
                print("error")
            }
        }catch{
            print("Error")
        }
    }
    
    func deleteAPersonRecord(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> =
        NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        fetchRequest.predicate = NSPredicate(
            format: "name = %@", "Person2")
        do{
            let fetchRecords = try managedContext.fetch(fetchRequest)
            let personObjectToBeDeleted = fetchRecords[0] as! NSManagedObject
            managedContext.delete(personObjectToBeDeleted)
            do{
                try managedContext.save()
            }catch{
                print("Error")
            }
        }catch{
            print("Error")
        }
    }
}
