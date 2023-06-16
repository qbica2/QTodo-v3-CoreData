//
//  TodoManager.swift
//  QTodo-v3.0
//
//  Created by Mehmet Kubilay Akdemir on 16.06.2023.
//

import Foundation
import CoreData


class TodoManager : ObservableObject {
    
    let container : NSPersistentContainer
    @Published var todos: [TodoEntity] = []

    init (){
        container = NSPersistentContainer(name: "TodoData")
        container.loadPersistentStores { description, error in
            if let error {
                print("Error Loading Core Data \(error.localizedDescription)")
            }
        }
        getTodos()
    }
    
    func getTodos(){
        let request = NSFetchRequest<TodoEntity>(entityName: "TodoEntity")

        do {
            todos = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching \(error.localizedDescription)")
        }
    }
    
    func addNewTodo(title: String, description: String, category: String, dueDate: Date? = nil){
        let newTodo = TodoEntity(context: container.viewContext)
        newTodo.id = UUID().uuidString
        newTodo.title = title
        newTodo.desc = description
        newTodo.category = category
        newTodo.isCompleted = false
        newTodo.dueDate = dueDate
        saveTodosToCoreData()
    }

    func saveTodosToCoreData(){
        do {
            try container.viewContext.save()
            getTodos()
        } catch let error {
            print("Saving errror \(error.localizedDescription)")
        }
    }
    
}
