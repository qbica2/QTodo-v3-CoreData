//
//  TodoDetail.swift
//  QTodo-v3.0
//
//  Created by Mehmet Kubilay Akdemir on 17.06.2023.
//

import SwiftUI

struct TodoDetailView: View {
    
    @EnvironmentObject var todoManager: TodoManager
    @EnvironmentObject var csm: CustomSheetManager
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var categoryID: Int16 = 0
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
                TitleSection
                DescriptionSection
                StatusSection
                CategorySection
                PrioritySection
                DueDateSection
            }
            .onAppear(perform: updateUI)
        }
         .navigationBarTitle("Edit Todo ✏️")
         .navigationBarTitleDisplayMode(.inline)
         .toolbar {
             ToolbarItem(placement: .navigationBarTrailing) {
                 SaveButton
             }
         }
         .sheet(isPresented: $csm.isCsActive) {
             CustomSheetView()
                 .presentationDetents([.height(300)])
         }
      
     }
}

//MARK: - Subviews

extension TodoDetailView {
    
    var TitleSection: some View {
        Section (content: {
            TextField(todo.title ?? "", text: $title)
                .foregroundColor(.pink)
        }, header: {
            Text("Change Title")
        })
    }
    
    var DescriptionSection: some View {
        Section (content: {
            TextField(todo.desc ?? "", text: $description)
                .foregroundColor(.pink)
        }, header: {
            Text("Change Description")
        })
    }
    
    var StatusSection: some View {
        Section {
            Toggle(isActive ? "Active" : "Passive" , isOn: $isActive)
                .tint(.pink)
        } header: {
            Text("Change Status")
        }
    }
    
    var CategorySection: some View {
        Section (content: {
            Picker("Category", selection: $categoryID) {
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
            Text("Change Priority")
        }
    }
    
    var DueDateSection: some View {
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
    
    var SaveButton: some View {
        Button(action: saveButtonPressed) {
            Text("Save")
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color.pink.opacity(0.8))
                .clipShape(Capsule())
        }
    }
}
//MARK: - Functions

extension TodoDetailView {
    
    func updateUI(){
        title = todo.title ?? ""
        description = todo.desc ?? ""
        categoryID = todo.categoryID
        priority = todo.priority
        isActive = !todo.isCompleted
        if todo.dueDate != nil {
            isScheduled = true
            dueDate = todo.dueDate ?? Date()
        }
    }
    
    func isTodoTitleValid(trimmedText: String) -> Bool {
        if trimmedText.isEmpty {
            csm.createErrorSheet(message: "Please enter a valid title!", emojis: "😱😨😰")
            return false
        }
        
        if trimmedText.count < 3 {
            csm.createErrorSheet(message: "New title must be at least 3 characters long!", emojis: "😱😨😰")
            return false
        }
        
        return true
    }
    
    func saveButtonPressed(){
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if isTodoTitleValid(trimmedText: trimmedTitle) {
            todoManager.updateTodo(todo: todo, newTitle: trimmedTitle, newDesc: description, newCategoryID: categoryID, newStatus: isActive, newPriority: priority, newDueDate: isScheduled ? dueDate : nil)
            dismiss()
        }
    }
}

struct TodoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            TodoDetailView(todo: TodoEntity(context: TodoManager().container.viewContext))
        }
        .environmentObject(TodoManager())
        .environmentObject(CustomSheetManager())
    }
}
