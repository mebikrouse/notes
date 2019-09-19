//
//  NotesRepository.swift
//  Notes
//
//  Created by Артур Мубаракшин on 07/09/2019.
//  Copyright © 2019 Артур Мубаракшин. All rights reserved.
//

import Foundation

class NotesRepository {
    private let saveFileName = "notes.dat"
    
    private(set) var notes: [Note] = []
    
    func add(note: Note) {
        guard !notes.contains(where: { $0.id == note.id }) else { return }
        notes.append(note)
    }
    
    func removeNote(with id: String) {
        notes.removeAll(where: { $0.id == id })
    }
    
    func removeNote(at index: Int) {
        notes.remove(at: index)
    }
    
    @discardableResult func loadNotesFromStorage() -> Bool {
        guard
            let saveFileUrl = getSaveFileUrl(for: saveFileName),
            let data = try? Data.init(contentsOf: saveFileUrl),
            let notes = deserializeNotes(from: data)
        else { return false }
        
        self.notes = notes
        return true
    }
    
    private func deserializeNotes(from data: Data) -> [Note]? {
        guard let array = try? JSONSerialization.jsonObject(with: data) as? [Any] else { return nil }
        
        var notes = [Note]()
        for item in array {
            guard
                let json = item as? [String: Any],
                let note = Note(from: json)
                else { return nil }
            
            notes.append(note)
        }
        return notes
    }
    
    @discardableResult func saveNotesToStorage() -> Bool {
        guard
            let saveFileUrl = getSaveFileUrl(for: saveFileName),
            let data = serializeNotes(from: notes)
        else { return false }
        
        do {
            try data.write(to: saveFileUrl)
            return true
        }
        catch { return false }
    }
    
    private func serializeNotes(from notes: [Note]) -> Data? {
        let array = notes.map({ $0.json })
        return try? JSONSerialization.data(withJSONObject: array)
    }
    
    private func getSaveFileUrl(for fileName: String) -> URL? {
        let libraryUrl = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first
        return libraryUrl?.appendingPathComponent(fileName, isDirectory: false)
    }
}
