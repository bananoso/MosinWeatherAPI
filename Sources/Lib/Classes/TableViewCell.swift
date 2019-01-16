//
//  TableViewCell.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 10.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    override var reuseIdentifier: String? {
        return String(describing: self)
    }
}
