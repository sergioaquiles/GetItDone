//
//  GetItDoneApp.swift
//  GetItDone
//
//  Created by Sergio Cardoso on 29/09/21.
//

import SwiftUI

@main
struct GetItDoneApp: App {
    
    var body: some Scene {
        WindowGroup {
            HomeView(taskVM: TaskViewModel())
                .environmentObject(NetworkingManager())
                .environmentObject(LocationManager())
                
        }
    }
}
