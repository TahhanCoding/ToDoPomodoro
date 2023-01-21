//
//  CoreDataManager.swift
//  ToDoPomodoros
//
//  Created by Ahmed Shaban on 21/01/2023.
//

import CoreData
import Foundation

// Note that CoreData isn't a data base itself but a framework to manage databases (XML , Binary, SQL , ..)
class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer // Class CoreDataManager has-A PC
    
    init() {
        // Creating instance of PC and init it with your model Name
        persistentContainer = NSPersistentContainer(name: "ToDoPomodorosModel")
        
        // Load data in your Model
        persistentContainer.loadPersistentStores { (description, error) in
            if let error {fatalError("Core Data Store failed \(error.localizedDescription)")}
        }
    }
    
    // Save Data into Model
    func save(title: String, pomodoros: Int16, Completed: Bool) {
        // Make a new instance of ToDoItem and init it with new properties got from user
        let toDoItem = ToDoItem(context: persistentContainer.viewContext)
        toDoItem.title = title
        toDoItem.pomodoros = pomodoros
        toDoItem.completed = Completed
        // save to persistentContainer
        do { try persistentContainer.viewContext.save() }
        catch { print("Failed to save \(error)") }
    }
    
    func delete(toDoItem: ToDoItem) {
        persistentContainer.viewContext.delete(toDoItem)
        // save the current state of the data base
        do {try persistentContainer.viewContext.save()}
         catch {
             // if saving changes failed, discard all changes
            persistentContainer.viewContext.rollback()
             // print the error
            print("Failed to save context \(error)")
        }
    }
    func updateModel() {
        // changing properties'values
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
        }
    }
    
    func loadData() -> [ToDoItem] {
        // Making a fetchRequest to load data, here ToDoItem, from data base model
        let fetchRequest: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
        
    }
    
    
    
    
}
