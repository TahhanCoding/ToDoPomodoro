//
//  ToDoItem.swift
//  ToDoPomodoros
//
//  Created by Ahmed Shaban on 07/01/2023.
//

import Foundation

struct TodoItem: Identifiable {
    let id = UUID()
    let title: String
    let pomodoros: Int
    var completed: Bool
}


struct Advice {
    let advice: String
}
