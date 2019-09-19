//
//  NoteEditController.swift
//  Notes
//
//  Created by Артур Мубаракшин on 07/09/2019.
//  Copyright © 2019 Артур Мубаракшин. All rights reserved.
//

import UIKit

class NoteEditController: UIViewController {
    @IBOutlet weak var textView: UITextView!

    var delegate: NoteEditControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextView()
        addKeyboardNotificationObservers()
    }
    
    private func configureTextView() {
        textView.textContainerInset = .equally(16)
        textView.inputAccessoryView = UIToolbar.doneToolbar(target: self, action: #selector(doneToolbarAction))
    }
    
    private func addKeyboardNotificationObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardDidShowAction(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHideAction(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.text = delegate?.initialText(for: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if delegate?.showKeyboard(for: self) == true {
            textView.becomeFirstResponder()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.noteEditController(self, didEndEditingNote: textView.text)
    }
    
    @objc func keyboardDidShowAction(notification: Notification) {
        guard let keyboardEndFrameHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else { return }
        setNoteContentTextViewInsets(.bottom(keyboardEndFrameHeight))
    }
    
    @objc func keyboardWillHideAction(notification: Notification) {
        setNoteContentTextViewInsets(.zero)
    }
    
    private func setNoteContentTextViewInsets(_ insets: UIEdgeInsets) {
        textView.contentInset = insets
        textView.scrollIndicatorInsets = insets
    }
    
    @objc func doneToolbarAction() {
        textView.endEditing(true)
    }
}
