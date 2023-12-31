//
//  AddNewTodo.swift
//  QTodo-v3.0
//
//  Created by Mehmet Kubilay Akdemir on 15.06.2023.
//

import SwiftUI

struct AddNewTodoView: View {
    
    @EnvironmentObject var todoManager: TodoManager
    @EnvironmentObject var csm: CustomSheetManager
    @Environment(\.dismiss) var dismiss
    
    @State private var todoTitle: String = ""
    @State private var todoDescription: String = ""
    @State private var categoryID: Int16 = 0
    @State private var isScheduled: Bool = false
    @State private var todoDueDate: Date = Date()
    @State private var priority: Float = 0
    
    let currentDate = Date()
    let oneMonthLater = Calendar.current.date(byAdding: .month, value: 1, to: Date())
    
    
    var body: some View {
        Form {
            TodoSection
            CategorySection
            PrioritySection
            DueDateSection
            SaveButton
            
            .sheet(isPresented: $csm.isCsActive, content: {
                CustomSheetView()
                    .presentationDetents([.height(300)])
            })
            .navigationTitle("Add New Todo")
        }
        .formStyle(.grouped)
    }
}
//MARK: - SUBVIEWS

extension AddNewTodoView {
    
    var TodoSection: some View {
        Section (content: {
            TextField("Title", text: $todoTitle)
            TextField("Description", text: $todoDescription)
        }, header: {
            Text("Todo")
        })
    }
    
    var CategorySection: some View {
        Section {
            Picker("Select a category", selection: $categoryID) {
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
        .onAppear {
            if todoManager.selectedCategoryID == 7 {
                categoryID = 0
            } else {
                categoryID = todoManager.selectedCategoryID
            }
        }
    }
    
    var PrioritySection: some View {
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
    }
    
    var DueDateSection: some View {
        Section {
            Toggle("Schedule Time", isOn: $isScheduled)
                .tint(.pink)
            DatePicker("Due Date", selection: $todoDueDate, in:currentDate...oneMonthLater! , displayedComponents: [.date])
                .disabled(!isScheduled)
                .tint(.pink)
        } header: {
            Text("Due Date")
        }
    }
    
    var SaveButton: some View {
        Button(action: saveButtonPressed) {
            Text("Save")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.vertical, 10)
                .background(Color.pink)
                .cornerRadius(10)
                .padding(.horizontal, 20)
        }
        .padding()
    }
}
//MARK: - FUNCTIONS

extension AddNewTodoView {
    
    func isTodoTitleValid(trimmedText: String) -> Bool {
        if trimmedText.isEmpty {
            csm.createErrorSheet(message: "Please enter a valid title!", emojis: "😱😨😰")
            return false
        }
        
        if trimmedText.count < 3 {
            csm.createErrorSheet(message: "Your new todo's title must be at least 3 characters long!", emojis: "😱😨😰")
            return false
        }
        
        return true
    }
    
    
    func saveButtonPressed(){
        let trimmedTitle = todoTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if isTodoTitleValid(trimmedText: trimmedTitle) {
            todoManager.addNewTodo(title: trimmedTitle, description: todoDescription, categoryID: categoryID, priority: priority, dueDate: isScheduled ? todoDueDate : nil)
            dismiss()
        }
    }
}

struct AddNewTodoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            AddNewTodoView()
        }
        .environmentObject(TodoManager())
        .environmentObject(CustomSheetManager())
    }
}
