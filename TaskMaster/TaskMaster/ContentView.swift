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
        
        CircleView(tasksArray: [])
        
    }
}




struct TaskInputView: View {
    @State var tasksArray: Array<Any>
    
    @State var newTask: String = ""    
    @State var willGoToTaskView: Bool = false
    @State var inputInstructionsColor: Color = Color.black
    
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
            Spacer()
            
            Button(
                action: {
                    if String(self.newTask).isEmpty{
                        self.inputInstructionsColor = Color.red
                    }
                    else{
                        
                        self.tasksArray.append( Task(label: self.newTask) )
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




struct CircleView: View {
    @State var tasksArray: Array<Any>
    
    var screenWidth = UIScreen.main.bounds.width
    @State private var willGoToTaskInputView = false
    
    
    var body: some View {
        VStack{
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

