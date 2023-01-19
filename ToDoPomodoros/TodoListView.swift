//
//  ContentView.swift
//  ToDoPomodoros
//
//  Created by Ahmed Shaban on 01/01/2023.
//

import SwiftUI



struct TodoListView: View {
    
    //MARK: Properties
    @State var todoItems: [TodoItem] = []
    @State var newTodoTitle = ""
    @State var newTodoPomodoros = 1
    
    @State var totalPomodoros = 0
    @State private var showPomodoroView = false
//    @State private var PomodorosRemaining = 0
    

    
    //MARK: Main View
    var body: some View {
        VStack {
            HStack {
                TextField("Task title", text: $newTodoTitle)
                Stepper(value: $newTodoPomodoros, in: 1...10) {
                    VStack {
                        Text("\(newTodoPomodoros)")
                        Image(systemName: "digitalcrown.horizontal.arrow.counterclockwise.fill")
                            .foregroundColor(.red)
                    }
                }
                Button(action: {
                    let todoItem = TodoItem(title: newTodoTitle, pomodoros: newTodoPomodoros, completed: false)
                    todoItems.append(todoItem)
                    newTodoTitle = ""
                    totalPomodoros += newTodoPomodoros
                    newTodoPomodoros = 1
                }) {
                    Text("Add")
                }
            }
            .padding()
            
            List {
                ForEach($todoItems) { $todoItem in
                    HStack {
                       Button(action: {
                                    self.showPomodoroView = true
                                }) {
                                    Text(todoItem.title)
                                        .foregroundColor(todoItem.completed ?
                                            .green : .gray)
                                }
                                .sheet(isPresented: $showPomodoroView) {
                                    // when sheet is dismissed, showPomodoroView is set to false
                                    PomodoroView()
                                }
                        
                        
                        Spacer()
                        Text("\(todoItem.pomodoros) pomodoros")

                    }
                }
            }
            .padding()
        }
    }
}


//
//struct TodoListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoListView()
//    }
//}
