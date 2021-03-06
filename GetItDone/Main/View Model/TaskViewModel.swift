//
//  HomeViewModel.swift
//  GetItDone
//
//  Created by Sergio Cardoso on 15/09/21.
//

import Foundation
import CoreData

class TaskViewModel: ObservableObject {
   

    @Published var savedTasks: [Tasks] = []
    var sortedTasks: [String : [Tasks]] {
        Dictionary(grouping: savedTasks) { $0.timestamp!.formatted(date: .abbreviated, time: .omitted) }
    }
    
    let container: NSPersistentContainer
    
    private let containerName = "GetItDone"
    private let entityName = "Tasks"
    
    init() {
        
        container = NSPersistentContainer(name: containerName)
        
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading Core Data. \(error)")
            } 
        }
        fetchTasks()
    }
    
    func fetchTasks() {
        
        let request = NSFetchRequest<Tasks>(entityName: entityName)
        
        do {
            savedTasks = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching \(error)")
        }
    }
    
    
    func addTask(name: String, priority: String, date: Date? = Date(), time: Date? = Date()) {
        let newTask = Tasks(context: container.viewContext)

        newTask.id = UUID()
        newTask.name = name
        newTask.priority = priority
        newTask.done = false
        newTask.alarm = false
        newTask.timestamp = date
        newTask.time = time
   
        saveTask()
    }
    
    
    func deleteTask(key: String, indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let task = sortedTasks[key]![index]
        if task.alarm {
            let id: String = "\(task.id!)"
            NotificationManager.instance.cancelNotification(id: id)
        }
        container.viewContext.delete(task)
        saveTask()
    }

    
    func updateTask(task: Tasks, name: String, priority: String, timestamp: Date, alarm: Bool, time: Date) {
        task.name = name
        task.priority = priority
        task.timestamp = timestamp
        task.alarm = alarm
        task.time = time
        saveTask()
    }
    
    func saveTask() {
        do {
            try container.viewContext.save()
            fetchTasks()
        } catch let error {
            print("Error saving data \(error)")
        }
    }
}
