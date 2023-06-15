//
//  MainView.swift
//  QTodo-v3.0
//
//  Created by Mehmet Kubilay Akdemir on 15.06.2023.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        VStack{
            CategoriesContentView()
            ListView()
            Spacer()
        }
        
        .navigationTitle("Qtodo")
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            MainView()
        }
    }
}
