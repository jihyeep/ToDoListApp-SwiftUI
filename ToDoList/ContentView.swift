//
//  ContentView.swift
//  ToDoList
//
//  Created by 박지혜 on 4/25/24.
//

import SwiftUI

struct ContentView: View {
    @State var tasks: [Task]
    
    var sortedTasks: [Task] {
        tasks.sorted(by: { (a, b) -> Bool in
            return a.priority > b.priority
        })
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(tasks.indices, id: \.self) { index in
                    HStack {
                        Button (action: {
                            tasks[index].completed.toggle()
                        }, label: {
                            Image(systemName: tasks[index].completed ? "checkmark.circle.fill" : "circle")
                        })
                        Text("\(tasks[index].description)")
                    }
                    HStack {
                        Picker("", selection: $tasks[index].priority) {
                            ForEach(Priority.allCases, id: \.self) { priority in
                                Text(priority.toString.capitalized)
                            }
                        }
                    }
                }
            }
//            .onAppear(perform: {
//                tasks = {
//                    tasks.sorted { (a, b) -> Bool in
//                    return a.priority < b.priority }
//                }()
//            })
            .navigationTitle("To do list")
        }
    }
}

#Preview {
    ContentView(tasks: Task.tasks)
}
