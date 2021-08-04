//
//  ViewController.swift
//  DB App
//
//  Created by Student on 8/4/21.
//

import UIKit
import Foundation
import CoreData

class ViewController: UIViewController {
    
    var dataManager : NSManagedObjectContext!
        var listArray = [NSManagedObject]()
    
    
    @IBAction func saveRecord(_ sender: Any) {
        
        let newEntity = NSEntityDescription.insertNewObject(forEntityName:"Item", into: dataManager)
               newEntity.setValue(enterPochita.text!, forKey: "about")

               do{
                   try self.dataManager.save()
                   listArray.append(newEntity)
               } catch{
                   print ("Error saving data")
               }
               displayDataHere.text?.removeAll()
        enterPochita.text?.removeAll();fetchData()
    }
    
    
    
    
    @IBAction func deleteRecord(_ sender: Any){
        
        let deleteItem = enterPochita.text!
                for item in listArray {
                    if item.value(forKey: "about") as! String == deleteItem {
                        dataManager.delete(item)
                    }
                    do {
                        try self.dataManager.save()
                    } catch {
                        print ("Error deleting data")
                    }
                    displayDataHere.text?.removeAll()
                    enterPochita.text?.removeAll()
                    fetchData()
                }
        
    }
    
    
    
    
    @IBOutlet var enterPochita: UITextField!
    
    
    
    
    @IBOutlet var displayDataHere: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                dataManager = appDelegate.persistentContainer.viewContext
                displayDataHere.text?.removeAll()
                fetchData()
            }


                // 14. Enter the fetchData function below.
                // GO BACK UP TO THE SAVE RECORD BUTTON FUNCTION TO COMPLETE STEP 15
            func fetchData() {

                let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Item")
                do {
                    let result = try dataManager.fetch(fetchRequest)
                    listArray = result as! [NSManagedObject]
                    for item in listArray {

                        let product = item.value(forKey: "about") as! String
                        displayDataHere.text! += product

                    }
                } catch {
                    print ("Error retrieving data")
                }


}

}
