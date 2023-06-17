//
//  CustomSheetManager.swift
//  QTodo-v3.0
//
//  Created by Mehmet Kubilay Akdemir on 17.06.2023.
//

import Foundation

enum CustomSheetType {
    case success
    case error
}

/*
       csm = CustomSheetManager
        cs = CustomSheet
 */

class CustomSheetManager: ObservableObject {
    
    @Published var isCsActive: Bool = false
    @Published var csType: CustomSheetType = .error
    @Published var csMessage: String = ""
    @Published var csEmojis: String = ""
    
    
    func createSuccesSheet(message: String, emojis: String){
        csType = .success
        csMessage = message
        csEmojis = emojis
        isCsActive.toggle()
    }
    
    func createErrorSheet(message: String, emojis: String) {
        csType = .error
        csMessage = message
        csEmojis = emojis
        isCsActive.toggle()
    }
    
}
