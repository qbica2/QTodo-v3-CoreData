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
    
    let filterOptions = ["All", "Active", "Completed"]
    
    var body: some View {
        VStack{
            CategoriesContentView()
            ListView()
            
            Picker("Filter", selection: $selectedFilter) {
                ForEach(filterOptions, id: \.self) { option in
                    Text(option)
                        .tag(option)
                }
            }
            .pickerStyle(.segmented)
            
        }
        
        .navigationTitle("Qtodo")
        .safeAreaInset(edge: .bottom, alignment: .trailing) {
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
        .onAppear(perform: getTodos)
        .onChange(of: selectedFilter) { filter in
            filterTodos(filter: filter)
        }
    }
    
}
//MARK: - FUNCTIONS

extension MainView {
    
    func getTodos(){
        todoManager.getTodos(for: todoManager.selectedCategoryID, filterOption: todoManager.selectedFilter)
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
