//
//  TodoDetail.swift
//  QTodo-v3.0
//
//  Created by Mehmet Kubilay Akdemir on 17.06.2023.
//

import SwiftUI

struct TodoDetailView: View {
    
    @EnvironmentObject var todoManager: TodoManager
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var isActive: Bool = false
    @State private var dueDate: Date = Date()
    @State private var isScheduled: Bool = false
    @State private var priority: Float = 80
    
    let currentDate = Date()
    let oneMonthLater = Calendar.current.date(byAdding: .month, value: 1, to: Date())

    
    let todo: TodoEntity
    
    var body: some View {
        VStack {
            Form {
                Section (content: {
                    TextField(todo.title ?? "", text: $title)
                        .foregroundColor(.pink)
                }, header: {
                    Text("Change Title")
                })
                
                Section (content: {
                    TextField(todo.desc ?? "", text: $description)
                        .foregroundColor(.pink)
                }, header: {
                    Text("Change Description")
                })
                
                Section {
                    Toggle("Status", isOn: $isActive)
                        .tint(.pink)
                } header: {
                    Text("Change Status")
                }
                
                Section (content: {
                    Picker("Category", selection: $todoManager.selectedCategoryID) {
                        ForEach(todoManager.categories, id: \.id) { item in
                            Text(item.name.capitalized)
                                .tag(item.id)
                        }
                    }
                    .tint(.pink)
                    .pickerStyle(.menu)
                }, header: {
                    Text("Change Category")
                })
                
                Section {
                    Slider(value: $priority,in: 0...100, step: 1) {
                        Text("Priority")
                    } minimumValueLabel: {
                        Text("0")
                            .foregroundColor(.pink)
                    } maximumValueLabel: {
                        Text("\(String(format: "%.0f", priority))/100")
                            .foregroundColor(.pink)
                    }
                    .tint(.pink)
                    
                } header: {
                    Text("Change Priority")
                }
                
                Section {
                    Toggle("Schedule Time", isOn: $isScheduled)
                        .tint(.pink)
                    DatePicker("Due Date", selection: $dueDate, in:currentDate...oneMonthLater! , displayedComponents: [.date])
                        .disabled(!isScheduled)
                        .tint(.pink)
                } header: {
                    Text("Change Due Date")
                }
                
            }
            .onAppear {
                title = todo.title ?? ""
                description = todo.desc ?? ""
                priority = todo.priority
                isActive = !todo.isCompleted
                if todo.dueDate != nil {
                    isScheduled = true
                    dueDate = todo.dueDate ?? Date()
                }
            }
        }
         .navigationBarTitle("Edit Todo ✏️")
         .navigationBarTitleDisplayMode(.inline)
      
     }
}

struct TodoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TodoDetailView(todo: TodoEntity(context: TodoManager().container.viewContext))
            .environmentObject(TodoManager())
    }
}
