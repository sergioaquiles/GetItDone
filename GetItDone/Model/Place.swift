//
//  Place.swift
//  GetItDone
//
//  Created by Sergio Cardoso on 18/10/21.
//

import Foundation
import CoreLocation


struct Place: Identifiable {
    
    let id = UUID().uuidString
    let place: CLPlacemark
   
}

