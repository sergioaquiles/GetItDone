//
//  NewTaskView.swift
//  GetItDone
//
//  Created by Sergio Cardoso on 15/09/21.
//

import SwiftUI

struct NewTaskView: View {
    
    @EnvironmentObject var taskVM: TaskViewModel
    
    @Binding var showNewTaskView: Bool
    @State var taskName: String = ""
    @State var priorityType: String = "Normal"
    private let priorities = ["Low", "Normal", "High"]
    private var isButtonDisable: Bool {
        taskName.isEmpty
    }
    
    var body: some View {
        VStack {
            Spacer()
            VStack{
                TextField("New Task", text: $taskName)
                    .foregroundColor(Color.theme.accent)
                    .font(.system(size: 18,weight: .semibold))
                    .padding(.leading)
                    .frame(height: 55)
                    .background(Color.gray.opacity(0.7))
                    .cornerRadius(10)
                Picker("Priority", selection: $priorityType) {
                    ForEach(priorities, id:\.self) {
                        Text($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .cornerRadius(5)
                
                Button {
                    taskVM.addTask(name: taskName, priority: priorityType)
                    taskName = ""
                    UIApplication.shared.endEditing()
                    feedback.notificationOccurred(.success)
                    showNewTaskView = false
                } label: {
                    Spacer()
                    Text("SAVE")
                        .font(.system(size: 24, weight: .semibold))
                    Spacer()
                }
                .disabled(isButtonDisable)
                .foregroundColor(Color.theme.accent)
                .padding()
                .background(isButtonDisable ? Color.theme.darkYellow.opacity(0.5) : Color.theme.darkYellow)
                .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.vertical, 20)
            .background(Color.theme.background)
            .cornerRadius(15)
        }
        .padding()
        .opacity(0.9)
        
    }
}

struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskView(showNewTaskView: .constant(true))
            .environmentObject(TaskViewModel())
    }
}
