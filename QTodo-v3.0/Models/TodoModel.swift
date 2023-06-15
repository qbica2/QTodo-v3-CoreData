//
//  TodoModel.swift
//  QTodo-v3.0
//
//  Created by Mehmet Kubilay Akdemir on 15.06.2023.
//

import Foundation


struct TodoModel: Identifiable, Hashable {
    let id: String = UUID().uuidString
    let title: String
    let description: String?
    let isCompleted: Bool
    let dueDate: Date?
}
