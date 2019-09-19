//
//  TableViewController.swift
//  Notes
//
//  Created by Артур Мубаракшин on 06/09/2019.
//  Copyright © 2019 Артур Мубаракшин. All rights reserved.
//

import UIKit

class NotesController: UITableViewController {
    private var notesRepository = NotesRepository()
    private var selectedNoteIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        notesRepository.loadNotesFromStorage()
        registerReusableCell()
        makeEmptyCellsToBeHidden()
        addNewNoteButton()
    }
    
    private func registerReusableCell() {
        let noteCellNib = UINib(nibName: "NoteCell", bundle: nil)
        tableView.register(noteCellNib, forCellReuseIdentifier: "NoteCell")
    }
    
    private func makeEmptyCellsToBeHidden() {
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func addNewNoteButton() {
        let newNoteButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newNoteButtonAction))
        navigationItem.rightBarButtonItem = newNoteButton
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesRepository.notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteCell
        let note = notesRepository.notes[indexPath.item]
        cell.configure(with: note.content, and: note.creationDate)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectNote(with: indexPath.item)
        showNoteEditController()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            notesRepository.removeNote(at: indexPath.item)
            saveNotesToStorage()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            break
        }
    }
    
    @objc func newNoteButtonAction() {
        deselectNote()
        showNoteEditController()
    }
    
    private func showNoteEditController() {
        let noteEditController = NoteEditController()
        noteEditController.delegate = self
        navigationController?.pushViewController(noteEditController, animated: true)
    }
    
    private func selectNote(with index: Int) {
        selectedNoteIndex = index
    }
    
    private func deselectNote() {
        selectedNoteIndex = nil
    }
    
    private func saveNotesToStorage() {
        if !notesRepository.saveNotesToStorage() {
            showErrorAlert(with: "Unable to save notes to storage!\nReinstall your application.")
        }
    }
    
    private func showErrorAlert(with text: String) {
        let alertController = UIAlertController(title: "Error", message: text, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension NotesController: NoteEditControllerDelegate {
    func initialText(for noteEditController: NoteEditController) -> String? {
        if let selectedNoteIndex = selectedNoteIndex {
            return notesRepository.notes[selectedNoteIndex].content
        } else {
            return nil
        }
    }
    
    func showKeyboard(for noteEditController: NoteEditController) -> Bool {
        return selectedNoteIndex == nil
    }
    
    func noteEditController(_ noteEditController: NoteEditController, didEndEditingNote editingResult: String) {
        if let selectedNoteIndex = selectedNoteIndex {
            if editingResult == notesRepository.notes[selectedNoteIndex].content {
                return
            }
            notesRepository.removeNote(at: selectedNoteIndex)
        } else if editingResult.isEmpty {
            return
        }
        
        notesRepository.add(note: Note(content: editingResult))
        saveNotesToStorage()
        
        tableView.reloadData()
    }
}
