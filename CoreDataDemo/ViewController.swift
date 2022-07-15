//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Kushal Rana on 15/07/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    
    // we need delegate object to access the corecdata files

    let delegateObject = UIApplication.shared.delegate as! AppDelegate
    
    
    
    // this is the mediator to play with coredata
    var context : NSManagedObjectContext!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataFromDataBase()
       
    }
   //Creating Database
    func createDataBase(){
        
        context = delegateObject.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "KushalDetails", in: context)
        
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        
        saveData(userDataBaseObject: newUser)
    }
    
    
    
    func saveData(userDataBaseObject: NSManagedObject){
        
        
        if userNameTF.text != "" , passwordTF.text != "" {
            
            userDataBaseObject.setValue(userNameTF.text, forKey: "name")
            userDataBaseObject.setValue(passwordTF.text, forKey: "password")
            
            do {
                try context.save()
                print("Data Saved")
            } catch {
                print("Not Saved..!!")
            }

        } else {
            alert()
        }
        
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        createDataBase()
    }
    
    
    
    // Mark:- Fetching data from database
    func fetchDataFromDataBase(){
        
        guard let appDelagete = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObejct = appDelagete.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "KushalDetails")
        
        
        do {
            let result  = try managedObejct.fetch(fetchRequest)
            for dataa in result as! [NSManagedObject] {
                
            
                
                guard let name = dataa.value(forKey: "name") as? String  else {
                    return
                }
                
                
                guard let password = dataa.value(forKey: "password") as? String  else {
                    return
                }
               
                    print(name)
                print(password)
                  //  print(dataa.value(forKey: "password") as! String)
                
               
                
            }
        } catch {
            print("")
        }
    }
    
    
    
   // Mark:- Alert Message Method
    func alert(){
        
        let alertController = UIAlertController(title: "Alert..!!!", message: "Please enter the valid details first", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
          
         }
         alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    func updateTabeInDataBase(){
        print("Still in progress")
    }
    
    func deleteDataFromDataBase(){
        print("Still in progress")
    }
    
    
    func newFucntionality(){
        // Subhash Added comments
    }
    
}

