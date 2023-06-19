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

enum FilterOption {
    case none
    case active
    case completed
}

class TodoManager : ObservableObject {
    
    let container : NSPersistentContainer
    @Published var todos: [TodoEntity] = []
    @Published var categories: [Category] = []
    @Published var selectedCategoryID: Int16 = 7
    @Published var selectedFilter: FilterOption = .none

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
    
    func getTodos(for categoryId: Int16, filterOption: FilterOption) {
        let request = NSFetchRequest<TodoEntity>(entityName: "TodoEntity")

        var predicates: [NSPredicate] = []

        if categoryId != 7 {
            predicates.append(NSPredicate(format: "categoryID == %d", categoryId))
        }

        switch filterOption {
        case .active:
            predicates.append(NSPredicate(format: "isCompleted == %@", NSNumber(value: false)))
        case .completed:
            predicates.append(NSPredicate(format: "isCompleted == %@", NSNumber(value: true)))
        case .none:
            break
        }

        if !predicates.isEmpty {
            let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
            request.predicate = compoundPredicate
        }

        do {
            todos = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching \(error.localizedDescription)")
        }
    }
    
    func saveContext(){
        do {
            try container.viewContext.save()
        } catch let error {
            print("Saving errror \(error.localizedDescription)")
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
        getTodos(for: selectedCategoryID, filterOption: selectedFilter)
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
    
    func deleteTodos(){
        for todo in todos {
            container.viewContext.delete(todo)
        }
        saveContext()
        getTodos(for: selectedCategoryID, filterOption: selectedFilter)
    }
    
    func isTodosEmpty() -> Bool {
        return todos.isEmpty
    }
    
    func setSelectedCategory(id: Int16){
        selectedCategoryID = id
        getTodos(for: selectedCategoryID, filterOption: selectedFilter)
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
