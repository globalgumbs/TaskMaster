//
//  TaskMasterApp.swift
//  TaskMaster
//
//  Created by LibUser on 2/28/22.
//

import SwiftUI

@main
struct TaskMasterApp: App {
    // link to data controller file for CoreData
    @StateObject private var dataController = DataController()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            // add data controller to app environment
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
