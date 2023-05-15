//
//  CoreDataManager.swift
//  YourSong
//
//  Created by Begum Unal on 13.05.2023.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    var model: SongModel?
    let entityName = "LikedItem"
    let persistentContainer: NSPersistentContainer
  //  let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    init() {
        persistentContainer = NSPersistentContainer(name: "YourSong")
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }

    // Veri kaydetme işlemi
    func saveData(withId id: Int, deviceID: String, isLiked: Bool) {
        let context = persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)!
        let newLike = NSManagedObject(entity: entity, insertInto: context)
        newLike.setValue(id, forKey: "id")
        newLike.setValue(deviceID, forKey: "deviceID")
        newLike.setValue(isLiked, forKey: "isLiked")
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // Veri silme işlemi
    func deleteData(withId id: Int, deviceID: String) {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id == %@ AND deviceID == %@", argumentArray: [id, deviceID])
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
    
    // Veri sorgulama işlemi
    func fetchData(withId id: Int, deviceID: String) -> Bool? {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id == %@ AND deviceID == %@", argumentArray: [id, deviceID])
        
        do {
            let result = try context.fetch(fetchRequest)
            if result.count == 0 {
                return nil // Veri yok
            } else {
                let like = result[0] as! NSManagedObject
                let isLiked = like.value(forKey: "isLiked") as! Bool
                return isLiked
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func checkDatabase(id: Int) -> Bool{
        let coreDataManager = CoreDataManager()
        if coreDataManager.fetchData(withId: id, deviceID: UIDevice.current.identifierForVendor!.uuidString) != nil {
            // Veri daha önce kaydedilmiş, silme işlemi yapılacak
            coreDataManager.deleteData(withId: id, deviceID: UIDevice.current.identifierForVendor!.uuidString)
            return true
        } else {
            // Veri daha önce kaydedilmemiş, kaydetme işlemi yapılacak
            coreDataManager.saveData(withId: id, deviceID: UIDevice.current.identifierForVendor!.uuidString, isLiked: true)
            return false
        }

    }
    func onlyCheckDatabase(id: Int) -> Bool{
        let coreDataManager = CoreDataManager()
        if coreDataManager.fetchData(withId: id, deviceID: UIDevice.current.identifierForVendor!.uuidString) != nil {
            return true
        } else {
            return false
        }

    }
    
    func fetchCoreDataObjects() -> [LikedItem]? {
        let fetchRequest: NSFetchRequest<LikedItem> = LikedItem.fetchRequest()
        
        do {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                let managedObjectContext = appDelegate.persistentContainer.viewContext
                let results = try managedObjectContext.fetch(fetchRequest)
                return results
            }
            return nil
        } catch {
            print("Hata: Veri çekme işlemi başarısız oldu - \(error.localizedDescription)")
            return nil
        }
    }

}
