//
//  CategoriesContentView.swift
//  QTodo-v3.0
//
//  Created by Mehmet Kubilay Akdemir on 15.06.2023.
//

import SwiftUI

struct CategoriesContentView: View {
    
    @EnvironmentObject var todoManager: TodoManager
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                CategoryView(category: Category(id: 7, name: "All", imageName: "square.grid.3x3.fill"))
                    .onTapGesture {
                        todoManager.setSelectedCategory(id: 7)
                    }
                ForEach(todoManager.categories, id: \.id) { category in
                    CategoryView(category: category)
                        .onTapGesture {
                            todoManager.setSelectedCategory(id: category.id)
                        }
                }
            }
            .frame(height: 120)
            .padding()
            
        }
    }
}

struct CategoriesContentView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesContentView()
            .environmentObject(TodoManager())
    }
}
