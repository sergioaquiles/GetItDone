//
//  TaskDetailView.swift
//  GetItDone
//
//  Created by Sergio Cardoso on 18/09/21.
//

import SwiftUI
import MapKit

struct TaskDetailView: View {
    
    
    @EnvironmentObject var taskVM: TaskViewModel
    
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var task: Tasks
    
    @State private var currentName = ""
    @State private var currentPriority = ""
    @State private var currentTimestamp = Date()
    @State private var currentAlarm = false
    
    private let priorities = ["Low", "Normal", "High"]
    
    @State var isButtonDateOn = true
    
    var body: some View {
        NavigationView {
            ZStack{
                
                Color.theme.background
                    .ignoresSafeArea()
                
                VStack {
                    Form {
                        Section {
                            TextField("", text: $task.name.boundString)
                            Picker("Priority", selection: $task.priority.boundString) {
                                ForEach(priorities, id:\.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .cornerRadius(5)
                        }
                        Section {
                            HStack {
                                HStack {
                                    Image(systemName: "calendar")
                                        .foregroundColor(Color.theme.secondaryText)
                                        .font(.system(size: 25))
                                    VStack(alignment:.leading) {
                                        Text("Date")
                                        if task.alarm {
                                            Text(task.timestamp ?? Date(), formatter: dateFormatter)
                                                .font(.system(size: 10))
                                        }
                                    }
                                }
                                Toggle("", isOn: $task.alarm)
                            }
                            if task.alarm {
                                DatePicker("", selection: $task.timestamp.boundDate, in: Date()...)
                                    .datePickerStyle(.compact)
                            }
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            TrailingNavButton
                        }
                        ToolbarItem(placement: .navigationBarLeading) {
                            LeadingNavButton
                        }
                    }
                    .accentColor(Color.theme.darkYellow)
                }
            }
            .onAppear(perform: {
                currentName = task.name ?? ""
                currentPriority = task.priority ?? ""
                currentAlarm = task.alarm
                currentTimestamp = task.timestamp ?? Date()
            })
            .navigationTitle("Details")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static let task = TaskViewModel()
    static var previews: some View {
        NavigationView {
            TaskDetailView(task: task.savedTasks[0])
                .preferredColorScheme(.dark)
                .environmentObject(TaskViewModel())
            
        }
    }
}

extension TaskDetailView {
    
    private var TrailingNavButton: some View {
        Button {
            if task.alarm {
                NotificationManager.instance.scheduleNotification(task: task)
            }
            taskVM.saveTask()
            feedback.notificationOccurred(.success)
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("SAVE")
        }
    }
    
    private var LeadingNavButton: some View {
        Button {
            uncommit()
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("CANCEL")
        }
    }
    
    func uncommit() {
        task.name = currentName
        task.priority = currentPriority
        task.alarm = currentAlarm
        task.timestamp = currentTimestamp
        taskVM.saveTask()
    }
}






