//
//  CoreDataManager.swift
//  SportsApp
//
//  Created by admin on 1/28/22.
//  Copyright © 2022 admin. All rights reserved.
//


import Foundation
import CoreData
class DataManager {
    static let shared = DataManager()
    static var context  = persistentContainer.viewContext
    private init(){}
    
    
    
    // MARK: - Core Data stack

    static var persistentContainer: NSPersistentContainer = {
     
          let container = NSPersistentContainer(name: "FavouriteLeagueModel")
          container.loadPersistentStores(completionHandler: { (storeDescription, error) in
              if let error = error as NSError? {
                  // Replace this implementation with code to handle the error appropriately.
                  // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                   
                  /*
                   Typical reasons for an error here include:
                   * The parent directory does not exist, cannot be created, or disallows writing.
                   * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                   * The device is out of space.
                   * The store could not be migrated to the current model version.
                   Check the error message to determine what the actual problem was.
                   */
                  fatalError("Unresolved error \(error), \(error.userInfo)")
              }
          })
          return container
      }()

      // MARK: - Core Data Saving support

static func saveContext () {
     //     let context = persistentContainer.viewContext
          if context.hasChanges {
              do {
                  try context.save()
                print("Saved Successfully")
              } catch {
                  // Replace this implementation with code to handle the error appropriately.
                  // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                  let nserror = error as NSError
                  fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
              }
          }
      }
    

  static  func fetchFromStorage() -> [FavouriteLeagueModel]? {
           let managedObjectContext = persistentContainer.viewContext
           let fetchRequest = NSFetchRequest<FavouriteLeagueModel>(entityName: "FavouriteLeagueModel")
//           let sortDescriptor1 = NSSortDescriptor(key: "role", ascending: true)
//           let sortDescriptor2 = NSSortDescriptor(key: "username", ascending: true)
        //   fetchRequest.sortDescriptors = [sortDescriptor1, sortDescriptor2]
           do {
               let leagues = try managedObjectContext.fetch(fetchRequest)
               return leagues
           } catch let error {
               print(error)
               return nil
           }
       }

   static func clearStorage() {
          let managedObjectContext = persistentContainer.viewContext
          let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteLeagueModel")
          let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
          do {
              try managedObjectContext.execute(batchDeleteRequest)
                print("DataBase Freed Successfully")
          } catch let error as NSError {
            print("can't free database")

              print(error)
          }
      }
    
    
    static func deleteLeague(withID: String) {
        let fetchRequest: NSFetchRequest<FavouriteLeagueModel> = FavouriteLeagueModel.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "idLeague=='\(withID)'")
        if let result = try? DataManager.context.fetch(fetchRequest) {
            for object in result {
                DataManager.context.delete(object)
            }
        }
        self.saveContext()
    }
    
}
