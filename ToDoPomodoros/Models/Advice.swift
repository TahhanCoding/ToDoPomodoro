//
//  Advice.swift
//  ToDoPomodoros
//
//  Created by Ahmed Shaban on 07/01/2023.
//
import Foundation

struct Result: Codable {
    let slip: Advice
}
struct Advice: Codable {
    let id: Int
    let advice: String
}

