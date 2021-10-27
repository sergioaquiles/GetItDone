//
//  Date.swift
//  GetItDone
//
//  Created by Sergio Cardoso on 23/09/21.
//

import Foundation
import SwiftUI


extension Optional where Wrapped == Date {
    var _boundDate: Date? {
        get {
            return self
        }
        set {
            self = newValue
        }
    }
    public var boundDate: Date {
        get {
            return _boundDate ?? Date()
        }
        set {
            _boundDate = newValue
        }
    }
}
