//
//  ItemCell.swift
//  ToDoTDD
//
//  Created by Hung Nguyen on 8/16/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    lazy var dateFormatter: NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    func configCellWithItem(item: ToDoItem, checked: Bool = false) {
        titleLabel.text = item.title
        locationLabel.text = item.location?.name
        
        if checked {
            let attributedTitle = NSAttributedString(string: item.title,
                                                     attributes: [NSStrikethroughStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue])
            titleLabel.attributedText = attributedTitle
            locationLabel.text = nil
            dateLabel .text = nil
        } else {
            titleLabel.text = item.title
            locationLabel.text = item.location?.name
            if let timestamp = item.timestamp {
                let date = NSDate(timeIntervalSince1970: timestamp)
                dateLabel.text = dateFormatter.stringFromDate(date)
            }
        }
    }
}
