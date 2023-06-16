//
//  CategoryView.swift
//  QTodo-v3.0
//
//  Created by Mehmet Kubilay Akdemir on 15.06.2023.
//

import SwiftUI

struct CategoryView: View {
    
    @EnvironmentObject var todoManager: TodoManager
    let category: Category
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(
                LinearGradient(gradient: Gradient(colors: [.pink, .pink.opacity(0.6)]), startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .frame(width: 100, height: 100)
            .overlay(
              VStack(spacing:10){
                  Image(systemName: category.imageName)
                      .resizable()
                      .scaledToFit()
                      .foregroundColor(.white)
                      .frame(width: 30, height: 30)
                      
                  Text(category.name.capitalized)
                      .font(.headline)
                      .foregroundColor(.white)
              }
            )
            .shadow(color: .white.opacity(todoManager.selectedCategoryID == category.id ? 0.9 : 0.1),radius: 10)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(category: Category(id: 3, name: "home", imageName: "house.fill"))
            .environmentObject(TodoManager())
    }
}
