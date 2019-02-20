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
        self.register(UINib(cellClass), forCellReuseIdentifier: typeString(cellClass))
    }
    
    func reloadRow(at indexPath: IndexPath, with animation: UITableView.RowAnimation) {
        self.reloadRows(at: [indexPath], with: animation)
    }
    
    func dequeueReusableCell<Cell: UITableViewCell>(
        withCellClass cellClass: Cell.Type,
        configurator: ((Cell) -> ())?
    )
        -> Cell
    {
        let cell = cast(self.dequeueReusableCell(withIdentifier: typeString(cellClass))) ?? Cell()
        configurator?(cell)
        
        return cell
    }
    
    func dequeueReusableCell<Cell: UITableViewCell>(
        withCellClass cellClass: Cell.Type,
        for indexPath: IndexPath,
        configurator: ((Cell, IndexPath) -> ())?
    )
        -> Cell
    {
        let cell = cast(self.dequeueReusableCell(withIdentifier: typeString(cellClass), for: indexPath)) ?? Cell()
        configurator?(cell, indexPath)
        
        return cell
    }
}
