//
//  WeatherViewController.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 10.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

fileprivate struct Strings {
    
    static let loadingError = "Loading error"
}

class WeatherViewController: UIViewController, RootViewRepresentable {

    typealias RootView = WeatherView
    
    public var networkManager: NetworkService?
    public var country: Country? {
        didSet {
            self.loadWeather()
        }
    }
    
    private var isFilled = false
    private let observer = CancellableProperty()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !self.isFilled {
            self.fillWithCountry()
        }
    }
    
    private func loadWeather() {
        self.subscribe()
        self.country.map {
            self.networkManager?.loadWeather(country: $0)
        }
    }
    
    private func subscribe() {
        self.observer.value = self.country?.observer { [weak self] _ in
            dispatchOnMain(self?.fillWithCountry)
        }
    }
    
    private func fillWithCountry() {
        self.rootView.do {
            $0.fill(with: self.country)
            self.isFilled = true
        }
    }
}
