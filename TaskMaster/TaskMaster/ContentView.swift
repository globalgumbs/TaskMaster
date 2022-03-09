//
//  ContentView.swift
//  TaskMaster
//
//  Created by LibUser on 2/28/22.
//

import SwiftUI
import Foundation

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack{
                Spacer()
                
                CircleView()
                
                Spacer()
                
                NavigationLink(
                    destination: TaskInputView(),
                    label: {
                    
                        AddTaskButton()
                    }
                )
                
            }
        }
    }
}

struct AddTaskButton: View {
    var body: some View {
        
        VStack{
            
            
            Image(
                systemName: "plus.circle.fill"
            )
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.black)
            
            
            Text("Add a task")
                .fontWeight(/*@START_MENU_TOKEN@*/.semibold/*@END_MENU_TOKEN@*/)
                .foregroundColor(.black)
                .padding()
            
        }
        
    }
    
    
}


struct TaskInputView: View {
    @State var newTask: String = ""
    
    var body: some View{
        NavigationView{
            VStack{
                Spacer()
                
                Text("New Task: \(newTask)")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                TextField(
                    "",
                    text: $newTask,
                    onCommit: {
                        
                    }
                )
                    .frame(width: 200, height: /*@START_MENU_TOKEN@*/30.0/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color(white: 0.816))
                    .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                
                Text("Input Task")
                
                Spacer()
                
                
                NavigationLink(
                    destination: ContentView(),
                    label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .frame(
                                    width: (CircleView().screenWidth - 50),
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
                        
                        .ignoresSafeArea()
                    }
                )
                
                
            }
        }
    }
}



struct CalendarButton: View{
    var body: some View{
        let dayVar = 2
        Button(
            action: {
                print("cal")
            },
            
            label: {
                Image(systemName: "\(dayVar).circle.fill")
                    .resizable(resizingMode: .tile)
                    .foregroundColor(.black)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 37.5, height: 37.5)
            }
        )
    }
}


struct Task: Identifiable {
    //Properties
    let label: String
    let id = UUID()
    
    
}

struct TaskView: View{
    // Properties
    var tasks: [Task] = [Task(label: "Protect Ya Neck")]
    
    // return true if there are tasks
    var areThereTasks: Bool {
        let tasksEmpty = tasks.isEmpty
        
        if tasksEmpty == false { //there are tasks
            return true
        }
        else { //array is empty (no tasks)
            return false
        }
    }
    
    
    // View
    var body: some View{
        
        if areThereTasks {
            
            List(tasks) {
                Text($0.label)
            }
            
        }
        else{
            
            Text("No Tasks")
            
        }
    }
}

struct CircleView: View {
    var screenWidth = UIScreen.main.bounds.width
    
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            LazyHStack{
                ForEach(0..<7) {_ in
                    VStack{
                        Text("March 4")
                        
                        ZStack{
                            Circle()
                                .frame(
                                    width: screenWidth * (2/3),
                                    height: screenWidth * (2/3))
                                .padding(.leading, 0)
                            
                            Text("Tasks: x")
                                .foregroundColor(Color.white)
                            
                        }
                    }
                }
            }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

