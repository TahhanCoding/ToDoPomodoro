//
//  ToDoPomodorosApp.swift
//  ToDoPomodoros
//
//  Created by Ahmed Shaban on 01/01/2023.
//

import SwiftUI

@main
struct ToDoPomodorosApp: App {
    var body: some Scene {
        WindowGroup {
            TodoListView(coreDM: CoreDataManager(),toDoItem: ToDoItem())
        }
    }
}
