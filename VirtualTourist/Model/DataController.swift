//
//  DataController.swift
//  VirtualTourist
//
//  Created by Yuan Gao on 12/27/22.
//

import Foundation
import CoreData

class DataController{
    let persistentContainer:NSPersistentContainer
    var viewContext:NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    init(modelName:String){
        persistentContainer = NSPersistentContainer(name: modelName)
 
    }
    

    
    func load(completion: (()->Void)?=nil){
        persistentContainer.loadPersistentStores { storeDescription, error in
            guard error == nil else{
                fatalError(error!.localizedDescription)
            }
            self.autoSaveViewContext(interval: 3)
            completion?()
        }
    }
    
}


extension DataController{
    func autoSaveViewContext(interval:TimeInterval = 30){
        //print("auto save")
        guard interval>0 else{
            print("cannott set negative autosave interval")
            return
        }
        if viewContext.hasChanges{
            try? viewContext.save()
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+interval){
            self.autoSaveViewContext(interval: interval)
        }
    }
}
