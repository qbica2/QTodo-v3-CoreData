//
//  ListView.swift
//  QTodo-v3.0
//
//  Created by Mehmet Kubilay Akdemir on 15.06.2023.
//

import SwiftUI

struct ListView: View {
    
    let todos: [TodoModel] = [
        TodoModel(title: "First Todo", description: "Ekmek al", isCompleted: false, dueDate: Date()),
        TodoModel(title: "Second Todo", description: "Çalış", isCompleted: true, dueDate: nil),
        TodoModel(title: "Thirt Todo", description: "Kitap oku", isCompleted: false, dueDate: nil),
    ]
    
    var body: some View {
        ZStack{
            List(todos) { todo in
                TodoView(todo: todo)
            }
        }
        .navigationDestination(for: TodoModel.self) { todo in
            Text("Todo: \(todo.title)")
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
