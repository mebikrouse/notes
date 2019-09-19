//
//  Note.swift
//  Notes
//
//  Created by Артур Мубаракшин on 06/09/2019.
//  Copyright © 2019 Артур Мубаракшин. All rights reserved.
//

import Foundation

struct Note {
    let id: String
    let content: String?
    let creationDate: Date
    
    init(id: String = UUID().uuidString, content: String? = nil, creationDate: Date = Date()) {
        self.id = id
        self.content = content
        self.creationDate = creationDate
    }
}
