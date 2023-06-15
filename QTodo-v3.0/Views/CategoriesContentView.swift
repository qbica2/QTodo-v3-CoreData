//
//  CategoriesContentView.swift
//  QTodo-v3.0
//
//  Created by Mehmet Kubilay Akdemir on 15.06.2023.
//

import SwiftUI

struct CategoriesContentView: View {
        
    let categories: [Category] = [
        Category(name: "personal", imageName: "person.fill"),
        Category(name: "Work", imageName: "briefcase.fill"),
        Category(name: "Shopping", imageName: "cart.fill"),
        Category(name: "Home", imageName: "house.fill"),
        Category(name: "Education", imageName: "book.fill"),
        Category(name: "health", imageName: "heart.fill"),
        Category(name: "other", imageName: "ellipsis")
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(categories, id: \.id) { category in
                    CategoryView(category: category)
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
    }
}
