//
//  ContentView.swift
//  ToDoList
//
//  Created by 박지혜 on 4/25/24.
//

import SwiftUI

struct ContentView: View {
    @State var tasks: [Task]
    
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
                }
            }
            .navigationTitle("To do list")
        }
    }
}

#Preview {
    ContentView(tasks: Task.tasks)
}
