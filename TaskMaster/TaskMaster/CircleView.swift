//
//  CircleView.swift
//  TaskMaster
//
//  Created by LibUser on 3/11/22.
//

import SwiftUI
import Foundation


struct CircleView: View {
    // Input Properties
    @State var tasksArray: Array<Task>
    
    
    // Properties
    @State private var willGoToTaskInputView = false
    var screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        VStack{
            ScrollView(.horizontal, showsIndicators: false){
                LazyHStack{
                    ForEach(0..<7) {i in
                        VStack{
                            
                            Text("\( getNextSeven()[i] )")
                            
                            ZStack{
                                Circle()
                                    .frame(
                                        width: screenWidth * (2/3),
                                        height: screenWidth * (2/3))
                                
                                Text("Tasks: \(self.tasksArray.count)")
                                    .foregroundColor(Color.white)
                                
                            }
                        }
                    }
                }
                .frame(height: /*@START_MENU_TOKEN@*/350.0/*@END_MENU_TOKEN@*/)
            }
            
            Spacer()
            
            Button( action: {
                self.willGoToTaskInputView = true
            }) {
                
                VStack{
                    
                    Image(
                        systemName: "plus.circle.fill"
                    )
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 80)
                        .foregroundColor(.black)
                    
                    
                    Text("Add a task")
                        .fontWeight(/*@START_MENU_TOKEN@*/.semibold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.black)
                    
                    
                    
                }
                
                
            }
            
            Spacer()
        }
        .navigate(to: TaskInputView(tasksArray: tasksArray), when: $willGoToTaskInputView)
    }

/*
    func getTaskDate(tasksArray: [Task], taskIndex: Int) -> String {
        let currentTask: Task = tasksArray[taskIndex]
        let taskDate: Date = currentTask.date
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "YY/MM/dd"
        let dateString = dateFormatter.string(from: taskDate)
        
        return dateString
    }
*/
    
    func myDateAsString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMMM d"
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    
    func getNextSeven() -> Array<String> {
        var myDate = Date.now
        var weekArray: [String] = []
        //let calDay = Calendar.current
        
        for _ in 0...6 {
            myDate = myDate.sameTimeNextDay()
        
            let newDateString = myDateAsString(date: myDate)
            weekArray.append(newDateString)
        }
        
        return weekArray
    }
    
    
}
