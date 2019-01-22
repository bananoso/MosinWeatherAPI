//
//  CountryViewCell.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 10.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

class CountryViewCell: TableViewCell {

    @IBOutlet var countryLabel: UILabel?
    @IBOutlet var capitalLabel: UILabel?
    @IBOutlet var temperaturelLabel: UILabel?
    @IBOutlet var dateLabel: UILabel?
    
    func fillWithModel(_ data: CountryData){
        self.countryLabel?.text = data.country.name
        self.capitalLabel?.text = data.country.capital
        
        self.temperaturelLabel?.text = data.weather?.main.celsiusString ?? ""
        self.dateLabel?.text = data.weather?.updateDate.formattedTime(style: .short) ?? ""
    }
}
