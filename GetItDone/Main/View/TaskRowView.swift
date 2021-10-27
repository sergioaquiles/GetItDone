//
//  TaskRowView.swift
//  GetItDone
//
//  Created by Sergio Cardoso on 17/09/21.
//

import SwiftUI

struct TaskRowView: View {
    
    @State var task: Tasks
    @EnvironmentObject var taskVM: TaskViewModel
    @State var showDetailView = false
    
    
    let priorityColors: [String: Color] = ["Normal": Color.theme.green, "Low": Color.theme.darkYellow, "High": Color.theme.red]
    
    var body: some View {
        Toggle(isOn: $task.done) {
            VStack(alignment: .leading, spacing: 2) {
                Text(task.name ?? "")
                    .font(.callout).fontWeight(.semibold)
                if task.alarm {
                    HStack(alignment: .bottom) {
                        Text(task.timestamp ?? Date(), formatter: dateFormatter)
                            .font(.caption)
                        Image(systemName: "bell")
                            .font(.caption)
                    }
                    .foregroundColor(Color.theme.secondaryText)
                }
            }
            Spacer()
            HStack{
                
                Capsule().stroke(lineWidth: 3)
                    .foregroundColor(priorityColors[task.priority ?? "Normal", default: Color.theme.green])
                    .frame(width: 55, height: 20)
                    .overlay(
                        Text(task.priority ?? "")
                            .font(.system(size: 12))
                    )
            }
            Button {
                withAnimation {
                    showDetailView = true
                }
            } label: {
                Image(systemName: "info.circle")
                    .font(.system(size: 20))
                    .foregroundColor(Color.theme.darkYellow)
        
            }
            .buttonStyle(BorderlessButtonStyle())
            .disabled(task.done)
            .fullScreenCover(isPresented: $showDetailView, content: {
                TaskDetailView(task: task)
            })
        }
        .toggleStyle(NewCheckBoxStyle())
        .opacity(task.done ? 0.6 : 1)
        .onReceive(task.objectWillChange, perform: { _ in
            if self.task.hasChanges{
                let id: String = "\(task.id!)"
                if task.done {
                    task.alarm = false
                    NotificationManager.instance.cancelNotification(id: id)
                }
                taskVM.saveTask()
            }
        })
        .padding(.horizontal, -2)
        .padding(.vertical, 5)
        
    }
}

struct TaskRowView_Previews: PreviewProvider {
    static let task = TaskViewModel()
    static var previews: some View {
        TaskRowView(task: task.savedTasks[0])
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
            .environmentObject(TaskViewModel())
    }
}
