//
//  TaskInputView.swift
//  TaskMaster
//
//  Created by LibUser on 3/11/22.
//

import SwiftUI
import Foundation
import SwiftyJSON

struct TaskInputView: View {
    
//MARK: Properties
    // Input Properties
    @State var tasksArray: Array<Task>
    
    // Initial Properties
    @State var newTask: String = ""
    @State var willGoToTaskView: Bool = false
    @State var inputInstructionsColor: Color = Color.black
    @State var taskDate = Date()
    
    let screenWidth = CircleView(tasksArray: []).screenWidth
  
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
                        self.inputInstructionsColor = Color.red
                    }
                    else{
                        
                        let task = Task(
                            label: self.newTask,
                            date: self.taskDate
                        )
                        
                        self.tasksArray.append(task)
                        print(addTaskToDatabase(task: task))
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
            to: CircleView(tasksArray: tasksArray),
            when: $willGoToTaskView)
    }
    
    
//MARK: Functions
    func addTaskToDatabase(task: Task) -> String {
        
            //let url = Bundle.main.path(forResource: "TaskCache", ofType: "json")
            //let fileStr = try? String(contentsOfFile: url!, encoding: String.Encoding.utf8)
            //print(fileStr)
            //let fileJson = JSON(fileStr)
        
            
            
        let encoder = JSONEncoder()
        let taskJson = try? (encoder.encode(task))
        let taskStr = String(data: taskJson!, encoding: .utf8)
        
        
            
            //let sumJson = try fileJson.merged(with: taskJson)
        //do {
           // if let finalStr = taskJson!.rawString() {
        let file = "TaskCache.json"
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            
        
            do {
                try taskStr!.write(to: fileURL, atomically: false, encoding: String.Encoding.utf8)
                //return taskStr!
            } catch {
                return error.localizedDescription
            }
            do {
                let text2 = try String(contentsOf: fileURL, encoding: .utf8)
                return text2
            }
            catch {
                return error.localizedDescription
            }
        }
            //} else {
                //print("No existe")
            //}
            
            //return("Weird")
       // } catch let myError {
      //      return("\(myError.localizedDescription)" )
      //  }
       // return "Made It"
        return "Idk atp"
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}
