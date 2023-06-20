//
//  FilterMenu.swift
//  QTodo-v3.0
//
//  Created by Mehmet Kubilay Akdemir on 20.06.2023.
//

import SwiftUI

struct SortMenuView: View {
    
    @EnvironmentObject var todoManager: TodoManager
    
    let sortOptions = ["Latest", "Oldest", "High Priority", "Low Priority", "Closest Due Date", "Farthest Due Date"]
    
    var body: some View {
        Menu {
            Section("Sorting Options") {
                ForEach(sortOptions, id: \.self) { option in
                    SortMenuButton(title: option)
                }
            }
        } label: {
            Image(systemName: "arrow.up.arrow.down.circle")
        }
    }
    
}
//MARK: - SubViews

struct SortMenuButton: View {
    
    @EnvironmentObject var todoManager: TodoManager
    
    let title: String
    
    var body: some View {
        Button {
            sortButtonPressed()
        } label: {
            HStack {
                Text(title)
                Image(systemName: sortOptionImageName())
            }
        }
    }
    
    func getTodos(){
        todoManager.getTodos(for: todoManager.selectedCategoryID, filterOption: todoManager.selectedFilter, sortOption: todoManager.selectedSortOption)
    }
    
    func sortButtonPressed(){
        switch title {
        case "Latest": todoManager.selectedSortOption = .latest
        case "Oldest": todoManager.selectedSortOption = .oldest
        case "High Priority": todoManager.selectedSortOption = .highPriority
        case "Low Priority": todoManager.selectedSortOption = .lowPriority
        case "Closest Due Date": todoManager.selectedSortOption = .closestDueDate
        case "Farthest Due Date": todoManager.selectedSortOption = .farthestDueDate
        default:
            break
        }
        
        getTodos()
    }
    
    func sortOptionImageName() -> String {
        switch todoManager.selectedSortOption {
        case .latest:
            return title == "Latest" ? "circle.fill" : "circle"
        case .oldest:
            return title == "Oldest" ? "circle.fill" : "circle"
        case .highPriority:
            return title == "High Priority" ? "circle.fill" : "circle"
        case .lowPriority:
            return title == "Low Priority" ? "circle.fill" : "circle"
        case .closestDueDate:
            return title == "Closest Due Date" ? "circle.fill" : "circle"
        case .farthestDueDate:
            return title == "Farthest Due Date" ? "circle.fill" : "circle"
        }
    }
}

struct SortMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SortMenuView()
            .environmentObject(TodoManager())
    }
}




