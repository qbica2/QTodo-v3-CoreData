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
            List {
                ForEach(todoManager.todos) { todo in
                    TodoView(todo: todo)
                        .swipeActions {
                            Button(role: .destructive) {
                                todoManager.deleteTodo(todo)
                            } label: {
                                Image(systemName: "trash")
                            }
                            .tint(.red)
                            
                            NavigationLink(value: todo) {
                                Image(systemName: "square.and.pencil")
                            }
                            .tint(.mint)
                        }
                }
                .onMove(perform: todoManager.moveTodos)
            }
            .listStyle(.insetGrouped)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
        .navigationDestination(for: TodoEntity.self) { todo in
            TodoDetailView(todo: todo)
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
