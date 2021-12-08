//
//  Constants.swift
//  GetItDone
//
//  Created by Sergio Cardoso on 18/09/21.
//

import SwiftUI


let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.dateFormat = "dd/MM/yy"
    formatter.timeStyle = .short
    return formatter
}()


let timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.dateFormat = .none
    formatter.timeStyle = .short
    return formatter
}()

let feedback = UINotificationFeedbackGenerator()
