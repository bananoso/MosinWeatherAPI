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
    
    public var country: Country? {
        didSet {
            self.country.do(self.fill)
        }
    }
    
    private let observer = CancellableProperty()
    
    private func fill(with country: Country) {
        let weather = country.weather
        
        self.countryLabel?.text = country.name
        self.capitalLabel?.text = country.capital

        self.observer.value = country.observer { [weak self] in
            if case .didChangeWeather = $0 {
                dispatchOnMain {
                    self?.temperaturelLabel?.text = weather?.celsiusDescription
                    self?.dateLabel?.text = weather?.updateDate.formattedTime(style: .short)
                }
            }
        }
    }
}
