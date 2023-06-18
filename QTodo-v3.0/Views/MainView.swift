//
//  MainView.swift
//  QTodo-v3.0
//
//  Created by Mehmet Kubilay Akdemir on 15.06.2023.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var todoManager: TodoManager
    
    var body: some View {
        VStack{
            CategoriesContentView()
            ListView()
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
        .onAppear {
            todoManager.getTodos(for: todoManager.selectedCategoryID)
        }
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
