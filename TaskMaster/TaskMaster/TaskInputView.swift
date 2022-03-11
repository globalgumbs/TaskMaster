//
//  TaskInputView.swift
//  TaskMaster
//
//  Created by LibUser on 3/11/22.
//

import SwiftUI
import Foundation

struct TaskInputView: View {
    @State var tasksArray: Array<Task>
    
    @State var newTask: String = ""
    @State var willGoToTaskView: Bool = false
    @State var inputInstructionsColor: Color = Color.black
    @State var taskDate = Date()
    
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
                in: Date()...,
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
                        
                        self.tasksArray.append(
                            Task(
                                label: self.newTask,
                                date: self.taskDate
                            ))
                        self.willGoToTaskView = true
                    }
                }
            )
                {
                    ZStack{
                    RoundedRectangle(cornerRadius: 10)
                        .frame(
                            width: (CircleView(tasksArray: []).screenWidth - 50),
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
}
