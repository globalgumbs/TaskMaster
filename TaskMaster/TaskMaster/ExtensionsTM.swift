//
//  ExtensionsTM.swift
//  TaskMaster
//
//  Created by LibUser on 3/25/22.
//

import Foundation
import SwiftUI



//MARK: Extensions for Date class
extension Date {    
    
    // returns Date object of next calendar date
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


//MARK: Extensions for View class
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


