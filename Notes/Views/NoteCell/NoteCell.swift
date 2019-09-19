//
//  NoteCell.swift
//  Notes
//
//  Created by Артур Мубаракшин on 06/09/2019.
//  Copyright © 2019 Артур Мубаракшин. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var secondaryDetailsLabel: UILabel!
    
    var titleString: String? {
        didSet {
            titleLabel.text = titleString
        }
    }
    
    var detailsString: String? {
        didSet {
            detailsLabel.text = detailsString
        }
    }
    
    var secondaryDetailsString: String? {
        didSet {
            secondaryDetailsLabel.text = secondaryDetailsString
        }
    }
    
    func configure(with content: String?, and date: Date?) {
        titleString = content?.meaningfulStrings.first ?? "No title"
        detailsString = content?.meaningfulStrings.second ?? "No details"
        secondaryDetailsLabel.text = date?.getStringRepresentation(timeStyle: .none, dateStyle: .short)
    }
}
