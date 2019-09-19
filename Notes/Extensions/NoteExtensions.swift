//
//  NoteExtensions.swift
//  Notes
//
//  Created by Артур Мубаракшин on 16/09/2019.
//  Copyright © 2019 Артур Мубаракшин. All rights reserved.
//

extension Note {
    var json: [String: Any] {
        var json = [String: Any]()
        
        if let content = content { json["content"] = content }
        json["id"] = id
        json["creationDate"] = creationDate.ISO8601String
        
        return json
    }
    
    init?(from json: [String: Any]) {
        let content = json["content"] as? String
        guard
            let id = json["id"] as? String,
            let creationDateString = json["creationDate"] as? String,
            let creationDate = creationDateString.ISO8601Date
            else { return nil }
        
        self.id = id
        self.content = content
        self.creationDate = creationDate
    }
}
