//
//  UIWindowExtensions.swift
//  Notes
//
//  Created by Артур Мубаракшин on 06/09/2019.
//  Copyright © 2019 Артур Мубаракшин. All rights reserved.
//

import UIKit

extension UIWindow {
    convenience public init(frame: CGRect, rootViewController: UIViewController) {
        self.init(frame: frame)
        self.rootViewController = rootViewController
    }
}
