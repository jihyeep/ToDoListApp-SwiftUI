//
//  ContentView.swift
//  ToDoList
//
//  Created by 박지혜 on 4/25/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var taskStore = TaskStore(tasks: Task.tasks)
    @State var isSheetShowing: Bool = false
    
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
                            .pickerStyle(.menu) // 버튼과 겹치는 문제 해결
                            // priority로 정렬
                            .onChange(of: taskStore.tasks[index].priority) { oldValue, newValue in
                                if let index = taskStore.tasks.firstIndex(where: {$0.id == taskStore.tasks[index].id}) {
                                    taskStore.tasks[index].priority = newValue
                                    taskStore.sortTasksByPriority()
                                }
                            }
                        }
                    }
                .onMove(perform: { indices, newOffset in
                    taskStore.tasks.move(fromOffsets: indices, toOffset: newOffset)
                })
                .onDelete(perform: { indexSet in
                    taskStore.tasks.remove(atOffsets: indexSet)
                })
            }
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
