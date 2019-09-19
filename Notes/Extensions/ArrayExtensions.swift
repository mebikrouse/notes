//
//  ArrayExtensions.swift
//  Notes
//
//  Created by Артур Мубаракшин on 06/09/2019.
//  Copyright © 2019 Артур Мубаракшин. All rights reserved.
//

import Foundation

extension Array {
    var second: Element? {
        return self.count > 1 ? self[1] : nil
    }
}
