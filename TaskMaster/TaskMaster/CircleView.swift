//
//  CircleView.swift
//  TaskMaster
//
//  Created by LibUser on 3/11/22.
//

import SwiftUI
import Foundation
import CoreData


struct CircleView: View {
//MARK: Properties
    
    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<CoreTask>
    @State private var willGoToTaskInputView = false
    @State private var willGoToDayView = false
    @State var dayViewDate: Date = Date()
    var screenWidth = UIScreen.main.bounds.width
    
//MARK: View
    
    var body: some View {
        VStack{
            ScrollView(.horizontal, showsIndicators: false){
                LazyHStack{
                    ForEach(0..<7) {i in
                        Button ( action: {
                            self.dayViewDate = getNextSeven()[i]
                            self.willGoToDayView = true
                        }) {
                            VStack {
                                
                                let today = getNextSeven()[i]
                                let taskCount = fetchDailyTasks(date: today, tasks: tasks).count
                                let dateString = stringifyDate(date: today)
                                
                                Text( dateString ).foregroundColor(.black)
                                
                                ZStack{
                                    Circle()
                                        .frame(
                                            width: screenWidth * (2/3),
                                            height: screenWidth * (2/3))
                                        .foregroundColor(.black)
                                    
                                    if taskCount == 0 {
                                        Text("No Tasks")
                                            .foregroundColor(Color.white)
                                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                    }
                                    else {
                                        Text("\(taskCount)")
                                            .foregroundColor(Color.white)
                                            .font(.largeTitle)
                                    }
                                }
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
        .navigate(to: DayView(date: self.dayViewDate), when: $willGoToDayView)
        .navigate(to: TaskInputView(), when: $willGoToTaskInputView)
    }
    
    
//MARK: Methods
    
    func stringifyDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMMM d"
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    
    func getNextSeven() -> Array<Date> {
        var myDate = Date.now
        var weekArray: [Date] = [myDate]
        
        for _ in 0...5 {
            myDate = myDate.sameTimeNextDay()
            
            weekArray.append(myDate)
        }
        
        return weekArray
    }
    
    func fetchDailyTasks(date: Date, tasks: FetchedResults<CoreTask>) -> [CoreTask] {
       
        var dailyTaskArr: [CoreTask] = []
        
        for task in tasks {
            if let taskDate = task.date {
                if stringifyDate(date: taskDate) == stringifyDate(date: date) {
                    dailyTaskArr.append(task)
                }
            } else {
            }
        }
        
        return dailyTaskArr
    }
    
    
}
