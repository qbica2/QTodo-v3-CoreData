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
    @Published var selectedCategoryID: Int16 = 0

    init (){
        container = NSPersistentContainer(name: "TodoData")
        container.loadPersistentStores { description, error in
            if let error {
                print("Error Loading Core Data \(error.localizedDescription)")
            }
        }
        getCategories()
        getTodos(for: selectedCategoryID)
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
    
    func getTodos(for categoryId: Int16){
        let request = NSFetchRequest<TodoEntity>(entityName: "TodoEntity")
        request.predicate = NSPredicate(format: "categoryID == %d", categoryId)

        do {
            todos = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching \(error.localizedDescription)")
        }
    }
    
    func addNewTodo(title: String, description: String, dueDate: Date? = nil){
        let newTodo = TodoEntity(context: container.viewContext)
        newTodo.id = UUID().uuidString
        newTodo.title = title
        newTodo.desc = description
        newTodo.categoryID = selectedCategoryID
        newTodo.isCompleted = false
        newTodo.dueDate = dueDate
        saveTodosToCoreData()
    }

    func saveTodosToCoreData(){
        do {
            try container.viewContext.save()
            getTodos(for: selectedCategoryID)
        } catch let error {
            print("Saving errror \(error.localizedDescription)")
        }
    }
    
    func setSelectedCategory(id: Int16){
        selectedCategoryID = id
        getTodos(for: selectedCategoryID)
    }
    
}
