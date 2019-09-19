//
//  UIEdgeInsetExtensions.swift
//  Notes
//
//  Created by Артур Мубаракшин on 07/09/2019.
//  Copyright © 2019 Артур Мубаракшин. All rights reserved.
//

import UIKit

extension UIEdgeInsets {
    static func bottom(_ value: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: value, right: 0)
    }
    
    static func equally(_ value: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }
}
