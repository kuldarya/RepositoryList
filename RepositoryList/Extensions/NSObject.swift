//
//  NSObject.swift
//  ListOfElements
//
//  Created by Darya Kuliashova on 18.03.21.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
