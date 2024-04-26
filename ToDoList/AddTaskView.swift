//
//  AddTaskView.swift
//  ToDoList
//
//  Created by 박지혜 on 4/26/24.
//

import SwiftUI

struct AddTaskView: View {
    @Binding var isSheetShowing: Bool
    @State var text: String = ""
    @State var selectedPriority: Priority = .medium
    @EnvironmentObject var taskStore: TaskStore
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("Task: ")
                    .padding()
                    .font(.title)
                    .bold()
                TextField("Enter about Task", text: $text)
                    .font(.headline)
                    .textFieldStyle(.plain)
            }
            HStack {
                Text("Priority: ")
                    .padding()
                    .font(.title)
                    .bold()
                Picker("Priority", selection: $selectedPriority) {
                    ForEach(Priority.allCases, id: \.self) { priority in
                        Text(priority.toString.capitalized)
                            .tag(priority)
                            .font(.title)
                            .foregroundStyle(.white)
                    }
                }
                .pickerStyle(.segmented)
                .frame(width: 200)
                .padding()
                .cornerRadius(15)
                .padding(.trailing)
            }
            Spacer()
            Button {
                // TODO: 할일 추가
                taskStore.addTask(text, selectedPriority)
                print(taskStore.tasks)
                isSheetShowing = false
            } label: {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                    Text("Done")
                        .font(.title)
                        .bold()
                }
            }
            .disabled(text.isEmpty)
        }
    }
}


#Preview {
    AddTaskView(isSheetShowing: .constant(true))
}
