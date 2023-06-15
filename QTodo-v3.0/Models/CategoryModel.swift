//
//  CategoryModel.swift
//  QTodo-v3.0
//
//  Created by Mehmet Kubilay Akdemir on 15.06.2023.
//

import Foundation

struct Category: Hashable {
    let id: String = UUID().uuidString
    let name: String
    let imageName: String
}
