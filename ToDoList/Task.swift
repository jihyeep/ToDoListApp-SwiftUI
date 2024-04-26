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
        Task(completed: false, description: "Sleep", priority: .low),
        Task(completed: false, description: "Get groceries", priority: .high)
    ]
    static var task = tasks[0]
}

// TODO: 저장소 추가
class TaskStore: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var isSortByPrirority: Bool = false
    
    init(tasks: [Task]) {
        // 기존 데이터 등록
        self.tasks = tasks
        sortTasksByPriority()
        print(tasks[0])
    }
    
    func addTask(_ text: String, _ selectedPriority: Priority) {
        let task: Task = Task(completed: false, description: text, priority: selectedPriority)
        tasks.append(task)
        sortTasksByPriority()
    }
    
    // priority 정렬 함수: case로 정렬
    func sortTasksByPriority() {
//        tasks.sort { $0.priority < $1.priority }
        if isSortByPrirority {
            tasks.sort(by: { (a, b) -> Bool in
                return a.priority < b.priority
            })
        } else {
            tasks.sort { $0.id < $1.id } // 기본 정렬 방식(id로 정렬)
        }
    }
    
    // priority 정렬 토글 함수
    func toggleSortByPriority() {
        isSortByPrirority.toggle()
        sortTasksByPriority()
    }
}
