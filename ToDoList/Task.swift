//
//  Task.swift
//  ToDoList
//
//  Created by 박지혜 on 4/25/24.
//

import Foundation

enum Priority: Comparable, CaseIterable {
    case high
    case medium
    case low
    
    var toString: String {
        switch self {
        case .high:
            return "high"        
        case .medium:
            return "medium"
        case .low:
            return "low"
        }
    }
    
    var toNum: Int {
        switch self {
        case .high:
            return 0
        case .medium:
            return 1
        case .low:
            return 2
        }
    }
    
//    static func < (lhs: Priority, rhs: Priority) -> Bool {
//        switch (lhs, rhs) {
//        case(.high, .medium), (.high, .low), (.medium, .low):
//            return false
//        default:
//            return true
//        }
//    }
}

struct Task: Identifiable {
    var id = UUID()
    var completed: Bool
    var description: String
    var priority: Priority
}

extension Task {
    static var tasks = [
        Task(completed: false, description: "Wake up", priority: .high ),
        Task(completed: false, description: "Shower", priority: .medium),
        Task(completed: false, description: "Code", priority: .high),
        Task(completed: false, description: "Eat", priority: .high ),
        Task(completed: false, description: "Sleep", priority: .high),
        Task(completed: false, description: "Get groceries", priority: .high)
    ]
    static var task = tasks[0]
}
