//
//  PreviewProvider.swift
//  GetItDone
//
//  Created by Sergio Cardoso on 15/09/21.
//

import Foundation
import SwiftUI


extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        DeveloperPreview.instance
    }
    
}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
   
    let homeVM = TaskViewModel()
    
    
    private init() { }
  
   
    
    
    
    
    
}
