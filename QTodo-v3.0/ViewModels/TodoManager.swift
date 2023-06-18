//
//  TodoManager.swift
//  QTodo-v3.0
//
//  Created by Mehmet Kubilay Akdemir on 16.06.2023.
//

import Foundation
import CoreData


/*
        selectedCategoryID
 
        0 => Personal
        1 => Work
        2 => Shopping
        3 => Home
        4 => Education
        5 => Health
        6 => Other
        7 => All
 */

class TodoManager : ObservableObject {
    
    let container : NSPersistentContainer
    @Published var todos: [TodoEntity] = []
    @Published var categories: [Category] = []
    @Published var selectedCategoryID: Int16 = 7

    init (){
        container = NSPersistentContainer(name: "TodoData")
        container.loadPersistentStores { description, error in
            if let error {
                print("Error Loading Core Data \(error.localizedDescription)")
            }
        }
        getCategories()
    }
    
    func getCategories(){
        let category1 = Category(id: 0, name: "Personal", imageName: "person.fill")
        let category2 = Category(id: 1, name: "Work", imageName: "briefcase.fill")
        let category3 = Category(id: 2, name: "Shopping", imageName: "cart.fill")
        let category4 = Category(id: 3, name: "Home", imageName: "house.fill")
        let category5 = Category(id: 4, name: "Education", imageName: "book.fill")
        let category6 = Category(id: 5, name: "Health", imageName: "heart.fill")
        let category7 = Category(id: 6, name: "Other", imageName: "ellipsis")
        
        categories.append(contentsOf: [category1, category2, category3, category4, category5, category6, category7])

    }
    
    func getTodos(for categoryId: Int16) {
        let request = NSFetchRequest<TodoEntity>(entityName: "TodoEntity")

        if categoryId != 7 {
            request.predicate = NSPredicate(format: "categoryID == %d", categoryId)
        }

        do {
            todos = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching \(error.localizedDescription)")
        }
    }
    
    func addNewTodo(title: String, description: String, categoryID: Int16, priority: Float, dueDate: Date? = nil){
        let newTodo = TodoEntity(context: container.viewContext)
        newTodo.id = UUID().uuidString
        newTodo.title = title
        newTodo.desc = description
        newTodo.categoryID = categoryID
        newTodo.priority = priority
        newTodo.isCompleted = false
        newTodo.dueDate = dueDate
        saveContext()
    }
    
    func deleteTodo(_ todo: TodoEntity) {
        container.viewContext.delete(todo)
        saveContext()
    }
    
    func moveTodos(indexSet: IndexSet, newIndex: Int) {
        todos.move(fromOffsets: indexSet, toOffset: newIndex)
    }
    
    func toggleTodo(todo: TodoEntity) {
        todo.isCompleted.toggle()
        saveContext()
    }
    
    func saveContext(){
        do {
            try container.viewContext.save()
        } catch let error {
            print("Saving errror \(error.localizedDescription)")
        }
    }
    
    func updateTodo(todo: TodoEntity, newTitle: String, newDesc: String, newCategoryID: Int16, newStatus: Bool, newPriority: Float, newDueDate: Date? = nil) {
        todo.title = newTitle
        todo.desc = newDesc
        todo.isCompleted = !newStatus
        todo.priority = newPriority
        todo.categoryID = newCategoryID
        todo.dueDate = newDueDate
        saveContext()
    }
    
    func setSelectedCategory(id: Int16){
        selectedCategoryID = id
        getTodos(for: selectedCategoryID)
    }
    
    func getTodoCount(for categoryId: Int16) -> Int {
        let request = NSFetchRequest<TodoEntity>(entityName: "TodoEntity")
        request.predicate = NSPredicate(format: "categoryID == %d", categoryId)

        do {
            let count = try container.viewContext.count(for: request)
            return count
        } catch let error {
            print("Error fetching count: \(error.localizedDescription)")
            return 0
        }
    }

}
