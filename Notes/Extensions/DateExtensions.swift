//
//  DateExtensions.swift
//  Notes
//
//  Created by Артур Мубаракшин on 06/09/2019.
//  Copyright © 2019 Артур Мубаракшин. All rights reserved.
//

import Foundation

extension Date {
    var ISO8601String: String {
        let formatter = ISO8601DateFormatter()
        return formatter.string(from: self)
    }
    
    func getStringRepresentation(timeStyle: DateFormatter.Style, dateStyle: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        return dateFormatter.string(from: self)
    }
}
