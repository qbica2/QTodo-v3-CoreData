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
    @Published var categories: [Category] = []
    @Published var selectedCategoryID: Int = 0

    init (){
        container = NSPersistentContainer(name: "TodoData")
        container.loadPersistentStores { description, error in
            if let error {
                print("Error Loading Core Data \(error.localizedDescription)")
            }
        }
        getCategories()
        getTodos()
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
    
    func getTodos(){
        let request = NSFetchRequest<TodoEntity>(entityName: "TodoEntity")

        do {
            todos = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching \(error.localizedDescription)")
        }
    }
    
    func addNewTodo(title: String, description: String, categoryID: Int, dueDate: Date? = nil){
        let newTodo = TodoEntity(context: container.viewContext)
        newTodo.id = UUID().uuidString
        newTodo.title = title
        newTodo.desc = description
        newTodo.categoryID = Int16(categoryID)
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
