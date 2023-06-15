//
//  AddNewTodo.swift
//  QTodo-v3.0
//
//  Created by Mehmet Kubilay Akdemir on 15.06.2023.
//

import SwiftUI

struct AddNewTodoView: View {
    
    @State private var todoText: String = ""
    @State private var todoDescription: String = ""
    @State private var isScheduled: Bool = false
    @State private var dueDate: Date = Date()
    @State private var category: String = "Other"
    
    let categories = [
        "Personal", "Work", "Shopping", "Home", "Education", "Healt", "Other"
    ]
    
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
                Picker("Select a category", selection: $category) {
                    ForEach(categories, id: \.self) { item in
                        Text(item.capitalized)
                            .tag(item.capitalized)
                    }
                }
                .pickerStyle(.menu)
            } header: {
                Text("Category")
            }

            
            Section {
                Toggle("Schedule Time", isOn: $isScheduled)
                DatePicker("Due Date", selection: $dueDate, in:currentDate...oneMonthLater! , displayedComponents: [.date])
                    .disabled(!isScheduled)
            } header: {
                Text("Due Date")
            }
            
            Button {
                
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

struct AddNewTodoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddNewTodoView()
        }
    }
}
