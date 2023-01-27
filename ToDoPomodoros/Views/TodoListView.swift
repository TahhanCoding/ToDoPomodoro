//
//  ContentView.swift
//  ToDoPomodoros
//
//  Created by Ahmed Shaban on 01/01/2023.
//

import SwiftUI

struct TodoListView: View {
    
    //MARK: Properties
    let coreDM: CoreDataManager
    @State var toDoItem: ToDoItem
    @State private var toDoItems: [ToDoItem] = [ToDoItem]()
    @State private var title: String = ""
    @State var pomodoros: Int16 = 1
    @State private var completed: Bool = false
    @State var totalPomodoros: Int16 = 0
    @State private var showPomodoroView = false
    
    //MARK: Main View
    var body: some View {
        VStack {
            HStack {
                TextField("Task title", text: $title)
                Stepper(value: $pomodoros, in: 1...10) {
                    VStack {
                        Text("\(pomodoros)")
                        Image(systemName: "digitalcrown.horizontal.arrow.counterclockwise.fill")
                            .foregroundColor(.red)
                    }
                }
                Button(action: {
                    coreDM.save(title: title, pomodoros: pomodoros, Completed: completed)
                    toDoItems = coreDM.loadData()
                    totalPomodoros += pomodoros
                    title = ""
                    pomodoros = 1
                }) {
                    Text("Add")
                }
            }
            .padding()
            List {
                ForEach($toDoItems, id: \.self) { $toDoItem in
                    HStack {
                        Button(action: {
                            self.showPomodoroView = true
                            self.toDoItem = toDoItem
                        }) {
                            Text(toDoItem.title ?? "").foregroundColor(toDoItem.completed ? .green : .gray)
                        }
                        Spacer()
                        Text("\(toDoItem.pomodoros)")
                        Image(systemName: "digitalcrown.horizontal.arrow.counterclockwise.fill")
                            .foregroundColor(.red)
                    }.sheet(isPresented: $showPomodoroView) {
                        PomodoroView(coreDM: coreDM, toDoItem: self.$toDoItem)
                    }
                }.onDelete(perform: { indexSet in
                    indexSet.forEach { index in
                        let toDoItem = toDoItems[index]
                        coreDM.delete(toDoItem: toDoItem)
                        toDoItems = coreDM.loadData()
                    }
                })
                .padding()
            }
        }
        .onAppear(perform: {
            toDoItems = coreDM.loadData()
        })
    }
}



//struct TodoListView_Previews: PreviewProvider {
//    static var previews: some View {
//        TodoListView()
//    }
//}
