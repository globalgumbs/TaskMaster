//
//  TaskInputView.swift
//  TaskMaster
//
//  Created by LibUser on 3/11/22.
//

import SwiftUI
import Foundation
import CoreData

struct TaskInputView: View {
    
    //MARK: Properties
 
    @Environment(\.managedObjectContext) var moc
    @State var newTask: String = ""
    @State var willGoToTaskView: Bool = false
    @State var inputInstructionsColor: Color = Color.black
    @State var taskDate = Date()
    
    let screenWidth = CircleView().screenWidth
    
    //MARK: View
    var body: some View{
        VStack{
            Spacer()
            
            Text("New Task: \(newTask)")
                .font(.title)
                .fontWeight(.bold)
            
            
            TextField(
                "",
                text: $newTask,
                onCommit: {}
            )
                .frame(width: 200, height: /*@START_MENU_TOKEN@*/30.0/*@END_MENU_TOKEN@*/)
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .background(Color(white: 0.816))
                .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
            
            Text("Input Task").foregroundColor(inputInstructionsColor)
            
            Spacer()
            
            
            DatePicker(
                selection: $taskDate,
                in: Date.now...,
                displayedComponents: .date,
                label: { Text("Date:") }
            )
                .frame(width: /*@START_MENU_TOKEN@*/180.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
            
            
            Spacer()
            
            
            Button(
                action: {
                    if String(self.newTask).isEmpty{
                        //_ = clearEntity(entityName: "CoreTask") //MARK: use this to reset
                        self.inputInstructionsColor = Color.red
                    }
                    else{
                        let coreTask = CoreTask(context: moc)
                            coreTask.label = self.newTask
                            coreTask.date = self.taskDate
                            coreTask.uuid = UUID()
                        try? moc.save()

                        self.willGoToTaskView = true
                    }
                }
            )
            {
                ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .frame(
                            width: (screenWidth - 50),
                            height: /*@START_MENU_TOKEN@*/50.0/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.black)
                    
                    
                    
                    HStack{
                        Text("Next")
                            .foregroundColor(.white)
                        
                        Image.init(systemName:
                                    "chevron.right.circle")
                            .foregroundColor(.white)
                        
                    }
                    
                }
            }
            
            Spacer()
        }
        .navigate(
            to: CircleView(),
            when: $willGoToTaskView)
    }
    
    
    //MARK: Functions
    
    // clear CoreData entity
    func clearEntity(entityName: String) -> Bool {
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)

        // Create Batch Delete Request
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try moc.execute(batchDeleteRequest)

        } catch {
            // Error Handling
        }
        
        return true
    }
    
}
