//
//  UIToolbarExtensions.swift
//  Notes
//
//  Created by Артур Мубаракшин on 07/09/2019.
//  Copyright © 2019 Артур Мубаракшин. All rights reserved.
//

import UIKit

extension UIToolbar {
    static func doneToolbar(target: Any?, action: Selector?) -> UIToolbar {
        let toolbar = UIToolbar(frame: .zero)
        
        toolbar.setItems([
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .done, target: target, action: action)
            ], animated: false)
        toolbar.sizeToFit()
        
        return toolbar
    }
}
