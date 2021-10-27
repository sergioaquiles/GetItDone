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
    @StateObject var mapVM = MapViewModel()
    
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var task: Tasks
    
    @State private var currentName = ""
    @State private var currentPriority = ""
    @State private var currentTimestamp = Date()
    @State private var currentAlarm = false
    @State private var showMap = false
    
    private let priorities = ["Low", "Normal", "High"]
    @State private var showAlert = false
    
    @State var isButtonDateOn = true
    @State var locationToggle = false
    
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
                                Button {
                                    withAnimation {
                                        isButtonDateOn.toggle()
                                    }
                                } label: {
                                }
                                .overlay(
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
                                    } ,alignment: .leading
                                )
                                .disabled(!task.alarm)
                                Toggle("", isOn: $task.alarm)
                                    .onChange(of: task.alarm) { newValue in
                                        if isButtonDateOn == false {
                                            isButtonDateOn = newValue
                                        }
                                    }
                            }
                            if task.alarm && isButtonDateOn {
                                DatePicker("", selection: $task.timestamp.boundDate, in: Date()...)
                                    .datePickerStyle(.compact)
                            }
                        }
                        
                        Section {
                            HStack {
                                Image(systemName: "location")
                                    .foregroundColor(Color.theme.secondaryText)
                                    .font(.system(size: 25))
                                Text("Location")
                                Toggle("", isOn: $locationToggle)
                                
                            }
                            if locationToggle {
                                VStack {
                                    Text(mapVM.address)
                                        .lineLimit(0)
                                        .multilineTextAlignment(.leading)
                                }
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
                    
                    Divider()
                    if locationToggle {
                        map
                            .ignoresSafeArea()
                    }
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
                .environmentObject(MapViewModel())
        }
    }
}

extension TaskDetailView {
    
    private var TrailingNavButton: some View {
        Button {
            if task.alarm {
                NotificationManager.instance.scheduleNotification(task: task, type: .calendar)
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
    
    
    private var map: some View {
        
        ZStack(alignment: .top) {
            
            Map(coordinateRegion: $mapVM.region, interactionModes: .all, showsUserLocation: true, annotationItems: mapVM.places) { place in
                MapAnnotation(coordinate: place.place.location!.coordinate) {
                    
                }
            }
            .ignoresSafeArea()
            
            VStack {
                SearchField(searchField: $mapVM.searchText)
                    .padding(.horizontal)
                    .padding(.top, 10)
                if mapVM.searchText != "" && !mapVM.places.isEmpty {
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(mapVM.places) { place in
                                Text(place.place.name ?? "No name")
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading)
                                Divider()
                            }
                        }
                    }
                    .background(Color.theme.background).opacity(0.8)
                    .cornerRadius(15)
                    .padding(.horizontal, 15)
                }
            }
        }
        .onChange(of: mapVM.searchText) { Value in
            let delay = 0.3
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                if Value == mapVM.searchText {
                    self.mapVM.searchLocation()
                }
            }
        }
    }
}


//    var taskName: Binding<String> {
//        Binding<String>  {
//            return self.task.name ?? ""
//        } set: { newName in
//            self.task.name = newName
//        }
//    }



