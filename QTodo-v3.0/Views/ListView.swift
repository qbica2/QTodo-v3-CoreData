//
//  ListView.swift
//  QTodo-v3.0
//
//  Created by Mehmet Kubilay Akdemir on 15.06.2023.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var todoManager: TodoManager
    
    var body: some View {
        ZStack{
            List(todoManager.todos) { todo in
                TodoView(todo: todo)
            }
        }
        .navigationDestination(for: TodoEntity.self) { todo in
            Text("Todo: \(todo.title ?? "asd")")
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ListView()
        }
        .environmentObject(TodoManager())
    }
}
