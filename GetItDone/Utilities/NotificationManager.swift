//
//  NotificationManager.swift
//  GetItDone
//
//  Created by Sergio Cardoso on 27/09/21.
//

import Foundation
import UserNotifications
import CoreLocation

enum NotificationType {
    case calendar
    case location
}


class NotificationManager {
    
    static let instance = NotificationManager()
    
        
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success , error in
            if let error = error {
                print("Error: \(error)")
            } else {
                print("Success")
            }
        }
    }
    
    func scheduleNotification(task: Tasks, type: NotificationType) {
        
        let id: String = "\(task.id!)"
        let content = UNMutableNotificationContent()
        content.title = "Get It Done"
        content.subtitle = task.name ?? ""
        content.sound = .default
        content.badge = 1
        
        if type == .calendar {
            
            
            let calendar = Calendar.current
            let day = calendar.component(.day, from: task.timestamp!)
            let month = calendar.component(.month, from: task.timestamp!)
            let hour = calendar.component(.hour, from: task.timestamp!)
            let min = calendar.component(.minute, from: task.timestamp!)
            
            var datecomponentes = DateComponents()
            datecomponentes.day = day
            datecomponentes.month = month
            datecomponentes.hour = hour
            datecomponentes.minute = min
            
            
            let triggerCalendar = UNCalendarNotificationTrigger(dateMatching: datecomponentes, repeats: false)
            
            let request = UNNotificationRequest(
                identifier: id,
                content: content,
                trigger: triggerCalendar)
            
            UNUserNotificationCenter.current().add(request)
        
        } else if type == .location {
            
            let coordinates = CLLocationCoordinate2D(latitude: task.lat, longitude: task.long)
            let region = CLCircularRegion(center: coordinates, radius: 100, identifier: id)
            region.notifyOnEntry = true
            region.notifyOnExit = true
            let locationTrigger = UNLocationNotificationTrigger(region: region, repeats: false)
            
            let request = UNNotificationRequest(identifier: id, content: content , trigger: locationTrigger)
            
            UNUserNotificationCenter.current().add(request)
        }
    }
    
    func cancelAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
    func cancelNotification(id: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }

}
