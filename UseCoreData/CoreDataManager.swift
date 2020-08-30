//
//  SharedInstanceClass.swift
//  UseCoreData
//
//  Created by Sose Yeritsyan on 5/11/20.
//  Copyright © 2020 Sose Yeritsyan. All rights reserved.
//
import Foundation
import CoreData
import UIKit
class CoreDataManager {
  
    static let sharedManager = CoreDataManager()
    private init() {} // Prevent clients from creating another instance.
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UseCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            
        })
    return container
  }()
  
  func saveContext () {
    let context = CoreDataManager.sharedManager.persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
    func insertUser(firstname: String? , lastname: String?, birthday: Date?, isMale: Bool?, height: Int16?, weight: Int16?, email: String?, phone: String?, password: String?) {

        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User",
                                              in: managedContext)!
        let person = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
        person.setValue(firstname, forKeyPath: "fname")
        person.setValue(lastname, forKeyPath: "lname")
        person.setValue(birthday, forKeyPath: "bday")
        person.setValue(isMale, forKeyPath: "ismale")
        
        person.setValue(height, forKeyPath: "height")
        person.setValue(weight, forKeyPath: "weight")
        person.setValue(email, forKeyPath: "email")
        person.setValue(phone, forKeyPath: "phone")
        person.setValue(password, forKeyPath: "psw")
      
        saveContext()
 
    }
    
    func isEmailExist(email: String) -> Bool { //if exists return true
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        var emalIsExists = true
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.predicate = NSPredicate(format: "email = %@", email)
        do {
            let result = try context.fetch(request)
            if result.count == 0 {
                emalIsExists = false
                        
            } else {
                emalIsExists = true
            }
            
            } catch {
                print(error)
            }
        
        return emalIsExists
    }
    
    func tryLogIn(email: String?, password: String?)->String {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.predicate = NSPredicate(format: "email = %@ AND psw = %@", email!, password!)
            
            var outputStr = ""
            do {
               let result = try context.fetch(request)
                if result.count > 0 {

                    outputStr+="there is " + String(result.count) + " users with email " + email! + " and with password " + password! + "\n"
                        
                    } else {
                    outputStr = "No Match Found!"
                }
                
            } catch {
                print(error)
            }
        return outputStr
    }
    
    func getUsers()->[User] {
        
        var users: [User] = []
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")

        do {
          users = try managedContext.fetch(fetchRequest) as! [User]
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        return users
    }
    
    
    func findUserByEmail(email: String?) -> User {
        var user = User()
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: "User")
        request.predicate = NSPredicate(format: "email = %@", email!)
        
        do {
          let users = try managedContext.fetch(request)
            if users.count == 1 {
                user = users[0] as! User
            }
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        return user
        
    }
    
    func editUserInfo(email:String?, firstname: String?, lastname: String?, birthday: Date?, ismale: Bool?, height: Int16?, weight: Int16?, phone: String?, password: String?) {
        
        let user = findUserByEmail(email: email)
        user.setValue(firstname, forKey: "fname")
        user.setValue(lastname, forKey: "lname")
        user.setValue(birthday, forKey: "bday")
        user.setValue(ismale, forKey: "ismale")
        user.setValue(height, forKey: "height")
        user.setValue(weight, forKey: "weight")
        user.setValue(phone, forKey: "phone")
        user.setValue(password, forKey: "psw")
        
        saveContext()
        
        
    }
    
    func deleteUser(email: String?) {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: "User")
        request.predicate = NSPredicate(format: "email = %@", email!)
        if let result = try? context.fetch(request) {
            for object in result {
                context.delete(object)
            }
        }
        saveContext()
    }
    
    
    func fetchAndPrintEachUser() {

            let managedObjContext = CoreDataManager.sharedManager.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
            do {
                let n = try managedObjContext.fetch(fetchRequest)
                
                print(n)
            } catch let error as NSError {
                print("Error while fetching the data:: ",error.description)
            }

        }

}
