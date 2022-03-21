//
//  ContentView.swift
//  TaskMaster
//
//  Created by LibUser on 2/28/22.
//

import SwiftUI
import Foundation
import CoreData

struct ContentView: View {    
    
    var body: some View {
        CircleView()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}








extension View {
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                
                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}


extension Date {
    func sameTimeNextDay(
        inDirection direction: Calendar.SearchDirection = .forward,
        using calendar: Calendar = .current
    ) -> Date {
        let components = calendar.dateComponents(
            [.hour, .minute, .second, .nanosecond],
            from: self
        )
        
        return calendar.nextDate(
            after: self,
            matching: components,
            matchingPolicy: .nextTime,
            direction: direction
        )!
    }
}



