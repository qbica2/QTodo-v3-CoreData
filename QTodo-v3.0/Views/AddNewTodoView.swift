//
//  AddNewTodo.swift
//  QTodo-v3.0
//
//  Created by Mehmet Kubilay Akdemir on 15.06.2023.
//

import SwiftUI

struct AddNewTodoView: View {
    
    @EnvironmentObject var todoManager: TodoManager
    
    @State private var todoText: String = ""
    @State private var todoDescription: String = ""
    @State private var isScheduled: Bool = false
    @State private var todoDueDate: Date = Date()
    @State private var priority: Float = 0
    
    let currentDate = Date()
    let oneMonthLater = Calendar.current.date(byAdding: .month, value: 1, to: Date())
    
    
    var body: some View {
        Form {
            Section (content: {
                TextField("Title", text: $todoText)
                TextField("Description", text: $todoDescription)
            }, header: {
                Text("Todo")
            })

            Section {
                Picker("Select a category", selection: $todoManager.selectedCategoryID) {
                    ForEach(todoManager.categories, id: \.id) { item in
                        Text(item.name.capitalized)
                            .tag(item.id)
                    }
                }
                .tint(.pink)
                .pickerStyle(.menu)
            } header: {
                Text("Category")
            }
            
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
                Text("Priority")
            }

            Section {
                Toggle("Schedule Time", isOn: $isScheduled)
                    .tint(.pink)
                DatePicker("Due Date", selection: $todoDueDate, in:currentDate...oneMonthLater! , displayedComponents: [.date])
                    .disabled(!isScheduled)
                    .tint(.pink)
            } header: {
                Text("Due Date")
            }
            
            Button {
                saveButtonPressed()
            } label: {
                Text("Save".uppercased())
                    .font(.title)
                    .foregroundColor(.pink)
                    .frame(maxWidth: .infinity,alignment: .center)
                    .padding(.vertical, 10)
            }

        }
        .navigationTitle("Add New Todo")
    }
}
//MARK: - FUNCTIONS

extension AddNewTodoView {
    func saveButtonPressed(){
        todoManager.addNewTodo(title: todoText, description: todoDescription, priority: priority, dueDate: isScheduled ? todoDueDate : nil)
    }
}

struct AddNewTodoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddNewTodoView()
        }
        .environmentObject(TodoManager())
    }
}
