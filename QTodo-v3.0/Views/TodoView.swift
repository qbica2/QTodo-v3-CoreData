//
//  TodoView.swift
//  QTodo-v3.0
//
//  Created by Mehmet Kubilay Akdemir on 15.06.2023.
//

import SwiftUI

struct TodoView: View {
    
    let todo: TodoEntity
    
    var body: some View {
        NavigationLink(value: todo) {
            HStack{
                Image(systemName: todo.isCompleted ? "circle.fill" : "circle")
                Text(todo.title ?? "title")
                
                if let dueDate = todo.dueDate {
                    Spacer()
                    Text(formatDate(dueDate))
                        .foregroundColor(.gray)
                }
            }
            .font(.headline)
            .foregroundColor(.pink.opacity(0.8))
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter.string(from: date)
    }
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView(todo: TodoEntity(context: TodoManager().container.viewContext))
    }
}
