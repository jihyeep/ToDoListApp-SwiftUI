//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by 박지혜 on 4/25/24.
//

import SwiftUI

@main
struct ToDoListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(tasks: Task.tasks)
        }
    }
}
