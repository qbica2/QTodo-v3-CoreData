//
//  EmptyListView.swift
//  QTodo-v3.0
//
//  Created by Mehmet Kubilay Akdemir on 20.06.2023.
//

import SwiftUI

struct EmptyListView: View {
    
    @EnvironmentObject var todoManager: TodoManager
    @State private var message: String = ""
    @State private var isAnimationActive: Bool = false
    
    var body: some View {
        VStack {
            MessageView
            AddTodoButton
        }
        .multilineTextAlignment(.center)
        .padding(30)
        .frame(maxWidth: 400)
        .onAppear(perform: changeTitle)
        .onChange(of: todoManager.selectedCategoryID) { _ in
            withAnimation(.spring()) {
                changeTitle()
            }
        }
        .onAppear {
            changeTitle()
            addAnimation()
        }
    }
}
//MARK: - SUBVIEWS

extension EmptyListView {
    
    var MessageView: some View {
        Text(message)
            .font(.headline)
            .foregroundColor(.pink.opacity(0.7))
            .padding()
    }
    
    var AddTodoButton: some View {
        NavigationLink(destination: {
            AddNewTodoView()
        }, label: {
            Text("Add New Todo")
                .font(.subheadline)
                .foregroundColor(.white)
                .frame(width: isAnimationActive ? 170 : 160, height: 50)
                .background(isAnimationActive ? Color.pink.opacity(0.8) : .pink.opacity(0.6))
                .cornerRadius(10)
                .scaleEffect(isAnimationActive ? 1.05 : 1.0)
        })
        .offset(y: isAnimationActive ? 10 : 0)
        .padding()
    }
}


//MARK: - FUNCTIONS

extension EmptyListView {
    
    func addAnimation() {
        guard !isAnimationActive else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                isAnimationActive.toggle()
            }
        }
    }
    
    func changeTitle(){
        switch todoManager.selectedCategoryID {
        case 0:
            message = "Perfect! No tasks left in the personal category. It could be a great day to allocate some time for yourself!"
        case 1:
            message = "Excellent! No tasks remaining in the work category. By using this time efficiently, you can further develop yourself."
        case 2:
            message = "Empty shopping list! It's a perfect time to discover new products or treat yourself a little."
        case 3:
            message = "It seems like you've completed all the tasks related to your home. Now you can reward yourself by relaxing in your cozy home!"
        case 4:
            message = "Your education tasks appear to be completed. Now you can allocate time to learn something new!"
        case 5:
            message = "Empty health list! You have the opportunity to engage in exercise or plan a healthy meal to make yourself feel better."
        case 6:
            message = "This category is empty! It's a great time to challenge yourself in a different field or experience something new."
        case 7:
            message = "Congratulations! You've completed all your tasks. Take a well-deserved break and enjoy your accomplishment!"
        default:
            break
        }
        
    }
}


struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView()
            .environmentObject(TodoManager())
    }
}
