//
//  MainView.swift
//  QTodo-v3.0
//
//  Created by Mehmet Kubilay Akdemir on 15.06.2023.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var todoManager: TodoManager
    @State private var selectedFilter: String = "All"
    @State private var showConfirmation: Bool = false
    @State private var showAlert: Bool = false
    
    let filterOptions = ["All", "Active", "Completed"]
    
    var body: some View {
        VStack{
            CategoriesContentView()
            
            if todoManager.todos.isEmpty {
                Spacer()
                EmptyListView()
                    .transition(AnyTransition.opacity.animation(.easeIn(duration: 0.8)))
            } else {
                ListView()
                FilterSection
            }
        }
        
        .navigationTitle("Qtodo")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                DeleteButton
            }
            ToolbarItem(placement: .navigationBarLeading) {
                SortMenuView()
            }
        }
        .tint(.pink)
        .safeAreaInset(edge: .bottom, alignment: .trailing) {
            AddTodoButton
        }
        .onAppear(perform: getTodos)
        .onChange(of: selectedFilter) { filter in
            filterTodos(filter: filter)
        }
        
        .alert("List already empty", isPresented: $showAlert, actions: {
            Button("OK") {
                showAlert = false
            }
        })
        
        .confirmationDialog("WARNİNG!!!", isPresented: $showConfirmation, titleVisibility: .visible) {
            Button(role: .destructive) {
                todoManager.deleteTodos()
            } label: {
                Text("YES")
            }

        } message: {
            Text("Are you sure you want to delete all the todos in the list? This action cannot be undone.")
        }
        
    }
    
}
//MARK: - SUBVIEWS

extension MainView {
    var FilterSection: some View {
        Picker("Filter", selection: $selectedFilter) {
            ForEach(filterOptions, id: \.self) { option in
                Text(option)
                    .tag(option)
            }
        }
        .pickerStyle(.segmented)
    }
    
    var DeleteButton: some View {
        Image(systemName: "trash")
            .foregroundColor(.pink)
            .onTapGesture {
                deleteButtonPressed()
            }
    }
    
    var AddTodoButton: some View {
        NavigationLink {
            AddNewTodoView()
        } label: {
            Image(systemName: "plus")
                .tint(.white)
                .padding()
                .background(Color.pink.opacity(0.8).ignoresSafeArea(edges: .bottom))
                .clipShape(Circle())
                .padding()
        }
    }
}

//MARK: - FUNCTIONS

extension MainView {
    
    func deleteButtonPressed(){
        if todoManager.isTodosEmpty() {
            showAlert.toggle()
        } else {
            showConfirmation.toggle()
        }
    }
    
    func getTodos(){
        todoManager.getTodos(for: todoManager.selectedCategoryID, filterOption: todoManager.selectedFilter, sortOption: todoManager.selectedSortOption)
    }
    
    func filterTodos(filter: String){
        switch filter {
        case "All": todoManager.selectedFilter = .none
        case "Active" : todoManager.selectedFilter = .active
        case "Completed" : todoManager.selectedFilter = .completed
        default:
            break
        }
        getTodos()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            MainView()
        }
        .environmentObject(TodoManager())
    }
}
