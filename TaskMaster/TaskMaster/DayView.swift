//
//  DayView.swift
//  TaskMaster
//
//  Created by LibUser on 3/12/22.
//

import Foundation
import SwiftUI

struct DayView: View {
    
// MARK: Properties
    
    //Input Properties
    let date: Date 
    
    
    //Other Properties
    @State var dailyTasks: [Task] = [Task(label: "Protect Ya Neck", date: Date()),
        Task(label: "Brush Your Teeth", date: Date()), Task(label: "Wash Your Face", date: Date())]
    
// MARK: View for each task
    var body: some View {
        VStack {
            let dateStr = CircleView(tasksArray: []).stringifyDate(date: date)
            
            Text(dateStr)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            ForEach(dailyTasks, id: \.self) {t in
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 40)
                            .frame(
                                width: CircleView(tasksArray: []).screenWidth - 50,
                                height: /*@START_MENU_TOKEN@*/100.0/*@END_MENU_TOKEN@*/)
                        
                        Text("\(t.label)").font(.title).foregroundColor(.white)
                            
                    }
                    .padding(.top)
                
            
            }
            Spacer()
        }
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(date: Date())
    }
}
