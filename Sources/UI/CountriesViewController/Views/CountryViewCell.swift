//
//  CountryViewCell.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 10.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

class CountryViewCell: TableViewCell {

    @IBOutlet var labelCountry: UILabel?
    @IBOutlet var labelCapital: UILabel?
    
    func fillWithModel(_ country: Country){
        self.labelCountry?.text = country.name
        self.labelCapital?.text = country.capital
    }
}
