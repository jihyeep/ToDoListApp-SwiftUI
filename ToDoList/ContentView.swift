//
//  ContentView.swift
//  ToDoList
//
//  Created by 박지혜 on 4/25/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var taskStore = TaskStore(tasks: Task.tasks)
    // 완료버튼과 priority 분리
//    @State var selectedPriority: Priority?
    @State var isSheetShowing: Bool = false
    
    var sortedTasks: [Task] {
        taskStore.tasks.sorted(by: { (a, b) -> Bool in
            return a.priority > b.priority
        })
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(taskStore.tasks.indices, id: \.self) { index in
                    HStack {
                        Button (action: {
                            taskStore.tasks[index].completed.toggle()
                        }, label: {
                            Image(systemName: taskStore.tasks[index].completed ? "checkmark.circle.fill" : "circle")
                        })
                        Text("\(taskStore.tasks[index].description)")
                        Picker("", selection: $taskStore.tasks[index].priority) {
                            ForEach(Priority.allCases, id: \.self) { priority in
                                Text(priority.toString.capitalized).tag(index)
                            }
                        }
                    }
//                    HStack {
//                        Picker("", selection: $tasks[index].priority) {
//                            ForEach(Priority.allCases, id: \.self) { priority in
//                                Text(priority.toString.capitalized).tag(index)
//                            }
//                        }
//                    }
                }
                .onMove(perform: { indices, newOffset in
                    taskStore.tasks.move(fromOffsets: indices, toOffset: newOffset)
                })
                .onDelete(perform: { indexSet in
                    taskStore.tasks.remove(atOffsets: indexSet)
                })
            }
//            .onAppear(perform: {
//                tasks = {
//                    tasks.sorted { (a, b) -> Bool in
//                    return a.priority < b.priority }
//                }()
//            })
            .navigationTitle("To do list")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        isSheetShowing.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                            Text("Add")
                                .font(.title)
                                .bold()
                        }
                        
                    }
                }
            }
            .sheet(isPresented: $isSheetShowing, content: {
                AddTaskView(isSheetShowing: $isSheetShowing)
            })
        }
        .environmentObject(taskStore)
    }
}

#Preview {
    ContentView()
}
