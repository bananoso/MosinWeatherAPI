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

public class WeatherViewController: UIViewController, RootViewRepresentable {

    // MARK: -
    // MARK: Subtypes
    
    typealias RootView = WeatherView
    
    // MARK: -
    // MARK: Properties
    
    public var country: Country? {
        didSet {
            self.loadWeather()
        }
    }
    
    public var networkManager: WeatherNetworkService<WeatherRealmDataBaseService>?
    
    private var isFilled = false
    private let observer = CancellableProperty()
    
    // MARK: -
    // MARK: View Lifecycle
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        if !self.isFilled {
            self.fillWithCountry()
        }
    }
    
    // MARK: -
    // MARK: Private
    
    private func loadWeather() {
        self.subscribe()
        self.country.do {
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
