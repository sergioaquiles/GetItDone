//
//  String.swift
//  GetItDone
//
//  Created by Sergio Cardoso on 22/09/21.
//

import Foundation
import SwiftUI


extension Optional where Wrapped == String {
    var _boundString: String? {
        get {
            return self
        }
        set {
            self = newValue
        }
    }
    public var boundString: String {
        get {
            return _boundString ?? ""
        }
        set {
            _boundString = newValue.isEmpty ? nil : newValue
        }
    }
}
