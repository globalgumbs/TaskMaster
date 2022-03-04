//
//  ContentView.swift
//  TaskMaster
//
//  Created by LibUser on 2/28/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            /*
             HStack{
             
             let mySpace = Spacer()
             .frame(width: 10.0)
             let myGroup = Group {
             CalendarButton()
             mySpace
             }
             
             
             mySpace
             myGroup
             myGroup
             myGroup
             myGroup
             myGroup
             myGroup
             myGroup
             mySpace
             
             }.padding()
             
             Spacer()
             
             TaskView()
             */
            Spacer()
            
            CircleView()
            
            Spacer()
            
            AddTaskButton()
            
        }
        
    }
}

struct AddTaskButton: View {
    var body: some View {
        Button(
            
            action: {
                print("yo")
            },
            
            label: {
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
            
        )
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
        
        if areThereTasks == true {
            
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
                            
                            Text("Hello")
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
