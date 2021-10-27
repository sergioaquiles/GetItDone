//
//  Color.swift
//  Color
//
//  Created by Sergio Cardoso on 14/09/21.
//

import Foundation
import SwiftUI


extension Color {
    
    static let theme = ColorTheme()
    
    struct ColorTheme {
        
        let accent = Color("AccentColor")
        let secondaryText = Color("SecondaryText")
        let background = Color("Background")
        let darkYellow = Color("YellowDark")
        let ligthYellow = Color("YellowLight")
        let red = Color("Red")
        let green = Color("Green")
        
    }
}
