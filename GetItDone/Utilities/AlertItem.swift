//
//  AlertItem.swift
//  GetItDone
//
//  Created by Sergio Cardoso on 06/10/21.
//

import SwiftUI



struct AlertItem: Identifiable {
    
    var id = UUID()
    var title: Text
    var message: Text
    var dismissButton: Alert.Button?

}


enum AlertContext {
    
    static let locationOff = AlertItem(title: Text("Location Services Desabled"),
                                       message: Text("You location services is off, go to settings and turn ir on"),
                                       dismissButton: .default(Text("Ok")))
    
    static let denied =  AlertItem(title: Text("Location Denied"),
                                   message: Text("You denied access to your locations, go to settings and change it"),
                                   dismissButton: .default(Text("OK")))
    
    static let restricted = AlertItem(title: Text("Location Restricted"),
                                      message: Text("your locations is restricted, go to settings and change it "),
                                      dismissButton: .default(Text("OK")))
      
}
