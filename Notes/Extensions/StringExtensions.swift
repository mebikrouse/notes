//
//  StringExtensions.swift
//  Notes
//
//  Created by Артур Мубаракшин on 06/09/2019.
//  Copyright © 2019 Артур Мубаракшин. All rights reserved.
//

import Foundation

extension String {
    var meaningfulStrings: [String] {
        return self.components(separatedBy: .newlines).map({ $0.trimmingCharacters(in: .whitespaces) }).filter({ !$0.isEmpty })
    }
    
    var ISO8601Date: Date? {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: self)
    }
}
