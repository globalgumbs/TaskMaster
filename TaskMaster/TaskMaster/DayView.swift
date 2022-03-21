//
//  DayView.swift
//  TaskMaster
//
//  Created by LibUser on 3/12/22.
//

import Foundation
import SwiftUI
import SwiftyJSON

struct DayView: View {
    
// MARK: Properties
    
    //Input Properties
    let date: Date
    
    
    //Initial Properties
    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<CoreTask>
    
        
    
    
// MARK: View
    var body: some View {
        VStack {
            let dateStr = CircleView().stringifyDate(date: date)
            
            Text(dateStr)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            let dailyTaskArr = fetchDailyTasks(date: date, tasks: tasks)
    
            ForEach(dailyTaskArr, id: \.self) {t in
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 40)
                            .frame(
                                width: CircleView().screenWidth - 50,
                                height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/)
                        
                        Text("\(t.label ?? "")").font(.title).foregroundColor(.white)
                            
                    }
                    .padding(.top)
            }

            Spacer()
        }
    }

//MARK: Methods
    func fetchDailyTasks(date: Date, tasks: FetchedResults<CoreTask>) -> [CoreTask] {
       
        var dailyTaskArr: [CoreTask] = []
        
        for task in tasks {
            if let taskDate = task.date {
                if CircleView().stringifyDate(date: taskDate) == CircleView().stringifyDate(date: date) {
                    dailyTaskArr.append(task)
                }
            } else {
            }
        }
        
        return dailyTaskArr
    }
}



struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(date: Date())
    }
}
