//
//  TodoView.swift
//  QTodo-v3.0
//
//  Created by Mehmet Kubilay Akdemir on 15.06.2023.
//

import SwiftUI

struct TodoView: View {
    
    @EnvironmentObject var todoManager: TodoManager
    @State var isACtive: Bool = false
    
    let todo: TodoEntity
    
    var body: some View {
        HStack{
            Image(systemName: isACtive ? "circle" : "circle.fill")
            Text(todo.title ?? "title")
            
            if let dueDate = todo.dueDate {
                Spacer()
                Text(formatDate(dueDate))
                    .foregroundColor(.gray)
            }
        }
        .font(.headline)
        .foregroundColor(.pink.opacity(0.8))
        .onTapGesture {
            withAnimation {
                isACtive.toggle()
                todoManager.toggleTodo(todo: todo)
            }
        }
        .onAppear {
            isACtive = !todo.isCompleted
        }
    }
}

//MARK: - Functions

extension TodoView {
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter.string(from: date)
    }
}

struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView(todo: TodoEntity(context: TodoManager().container.viewContext))
            .environmentObject(TodoManager())
    }
}
