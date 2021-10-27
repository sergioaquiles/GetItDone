//
//  HideKeyboard.swift
//  GetItDone
//
//  Created by Sergio Cardoso on 17/09/21.
//

import SwiftUI


extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}



