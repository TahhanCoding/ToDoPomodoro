//
//  ContentView.swift
//  ToDoPomodoros
//
//  Created by Ahmed Shaban on 01/01/2023.
//

import SwiftUI

struct TodoItem: Identifiable {
    let id = UUID()
    let title: String
    let pomodoros: Int
    var completed: Bool
}

struct TodoListView: View {
    @State var todoItems: [TodoItem] = []
    @State var newTodoTitle = ""
    @State var newTodoPomodoros = 1
    @State var totalPomodoros = 0
    
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
                            todoItem.completed.toggle()
                        }) {
                            Image(systemName: todoItem.completed ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(todoItem.completed ? .green : .gray)
                        }
                        Text(todoItem.title)
                        Spacer()
                        Text("\(todoItem.pomodoros) pomodoros")
                        
                    }
                }
            }
            .padding()
            
            PomodoroTimerView(pomodorosRemaining: $totalPomodoros)
        }
    }
}

struct PomodoroTimerView: View {
    @Binding var pomodorosRemaining: Int
    @State var timerRunning = false
//    @State var secondsRemaining = 1500 // 25 minutes in seconds
    @State var secondsRemaining = 10

    
    var body: some View {
        VStack {
            Text("\(pomodorosRemaining) pomodoros remaining")
            Text("\(secondsRemaining / 60):\(secondsRemaining % 60)")
            Button(action: {
                if timerRunning {
                    timerRunning = false
                } else {
                    timerRunning = true
                }
            }) {
                Text(timerRunning ? "Stop" : "Start")
            }
            .padding()
        }
        .onReceive(timerPublisher) { _ in
            if timerRunning {
                secondsRemaining -= 1
                if secondsRemaining == 0 {
                    pomodorosRemaining -= 1
                    secondsRemaining = 10
                }
            }
        }
    }
    
    private let timerPublisher = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
    }
}
