//
//  CategoryView.swift
//  QTodo-v3.0
//
//  Created by Mehmet Kubilay Akdemir on 15.06.2023.
//

import SwiftUI

struct CategoryView: View {
    
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
            .shadow(color: .white.opacity(0.6),radius: 5)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(category: Category(name: "home", imageName: "house.fill"))
    }
}
