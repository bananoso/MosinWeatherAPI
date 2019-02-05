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
    
    func fill(with wrappedCountry: Wrapper<Country>) {
        let country = wrappedCountry.value
        let weather = country.weather
        
        self.countryLabel?.text = country.name
        self.capitalLabel?.text = country.capital
        
        self.temperaturelLabel?.text = weather?.celsiusDescription
        self.dateLabel?.text = weather?.updateDate.formattedTime(style: .short)
    }
}
