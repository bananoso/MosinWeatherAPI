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
            self.prepareObserver()
            self.fillWithModel()
        }
    }
    
    public var cancellableObserver: Cancellable? {
        get { return self.cellObserverProperty.value }
        set { self.cellObserverProperty.value = newValue }
    }
    
    private let cellObserverProperty = CancellableProperty()
    private let countryObserver = CancellableProperty()
    
    private func prepareObserver() {
        self.countryObserver.value = self.country?.observer { [weak self] _ in
            dispatchOnMain {
                self?.fillWithModel()
            }
        }
    }
    
    private func fillWithModel() {
        let country = self.country
        let weather = country?.weather
        
        self.countryLabel?.text = country?.name
        self.capitalLabel?.text = country?.capital
        self.temperaturelLabel?.text = weather?.celsiusDescription
        self.dateLabel?.text = weather?.updateDate.formattedTime(style: .short)
    }
}
