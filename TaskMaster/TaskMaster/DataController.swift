//
//  DataController.swift
//  TaskMaster
//
//  Created by LibUser on 3/21/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "TaskData")
    
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Abeez says Core Data failed to load \(error.localizedDescription)")
            }
            
        }
    }
}
