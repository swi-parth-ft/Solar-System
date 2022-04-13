//
//  CoreData.swift
//  Solar
//
//  Created by Parth Antala on 2022-04-04.
//

import Foundation
import CoreData

class CoreData{
    
    static var Shared = CoreData()
    
    func insertDataIntoStorage(englishName: String, bodyType: String, name: String, gravity: Double, density: Double, escape: Double, avgTemp:Double){
            
        let newFav = SolarFav(context: persistentContainer.viewContext)
        newFav.englishName = englishName
        newFav.bodyType = bodyType
        newFav.name = name
        newFav.gravity = Double(gravity)
        newFav.density = Double(density)
        newFav.escape = Double(escape)
        newFav.avgTemp = Double(avgTemp)
        saveContext()
    }
    
    func getAllDataFromStorage() -> [SolarFav] {
        
        var result = [SolarFav]()
        let dataFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "SolarFav")
        do {
        result = try
            persistentContainer.viewContext.fetch(dataFetch) as [SolarFav]
            
          print(result.count)
        }catch {
            print (error)
            
        }
        return result
    }
    
    
    lazy var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "Solar")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
             
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    public func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
               
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func delete(delete: SolarFav){
        persistentContainer.viewContext.delete(delete)
        saveContext()
    }

    
}
