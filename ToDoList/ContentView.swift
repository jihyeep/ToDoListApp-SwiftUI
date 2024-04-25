//
//  ContentView.swift
//  ToDoList
//
//  Created by 박지혜 on 4/25/24.
//

import SwiftUI

struct ContentView: View {
    @State var tasks: [Task]
    // 완료버튼과 priority 분리
//    @State var selectedPriority: Priority?
    @State var isSheetShowing: Bool = false
    
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
                        Picker("", selection: $tasks[index].priority) {
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
                    tasks.move(fromOffsets: indices, toOffset: newOffset)
                })
                .onDelete(perform: { indexSet in
                    tasks.remove(atOffsets: indexSet)
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
    }
}

#Preview {
    ContentView(tasks: Task.tasks)
}
