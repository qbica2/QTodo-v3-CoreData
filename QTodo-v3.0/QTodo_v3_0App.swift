//
//  QTodo_v3_0App.swift
//  QTodo-v3.0
//
//  Created by Mehmet Kubilay Akdemir on 15.06.2023.
//

import SwiftUI

@main
struct QTodo_v3_0App: App {
    
    @StateObject var todoManager: TodoManager = TodoManager()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                MainView()
            }
            .environmentObject(todoManager)
        }
    }
}
