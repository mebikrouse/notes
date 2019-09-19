//
//  NoteEditControllerDelegate.swift
//  Notes
//
//  Created by Артур Мубаракшин on 07/09/2019.
//  Copyright © 2019 Артур Мубаракшин. All rights reserved.
//

import Foundation

protocol NoteEditControllerDelegate {
    func initialText(for noteEditController: NoteEditController) -> String?
    func showKeyboard(for noteEditController: NoteEditController) -> Bool
    func noteEditController(_ noteEditController: NoteEditController, didEndEditingNote editingResult: String)
}
