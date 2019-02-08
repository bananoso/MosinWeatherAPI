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
    
    public var networkManager: NetworkManager?
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
            self.fill()
        }
    }
    
    private func loadWeather() {
        self.country.do {
            self.subscribe(country: $0)
            self.networkManager?.loadWeather(country: $0)
        }
    }
    
    private func subscribe(country: Country) {
        self.observer.value = country.observer { _ in
            dispatchOnMain(self.fill)
        }
    }
    
    private func fill() {
        self.rootView.do {
            $0.fill(with: self.country)
            self.isFilled = true
        }
    }
}
