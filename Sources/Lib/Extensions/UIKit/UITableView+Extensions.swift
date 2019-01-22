//
//  UITableView+Extensions.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 15.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register(_ cellClass: AnyClass) {
        self.register(UINib(cellClass), forCellReuseIdentifier: toString(cellClass))
    }
    
    func dequeueReusableCell<Cell: UITableViewCell>(withCellClass cellClass: Cell.Type) -> Cell? {
        return cast(self.dequeueReusableCell(withIdentifier: toString(cellClass)))
    }
    
    func dequeueReusableCell<Cell: UITableViewCell>(
        withCellClass cellClass: Cell.Type,
        for indexPath: IndexPath
    )
        -> Cell?
    {
        return cast(self.dequeueReusableCell(withIdentifier: toString(cellClass), for: indexPath))
    }
}
