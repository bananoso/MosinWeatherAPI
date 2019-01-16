//
//  WeatherViewController.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 10.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, RootViewRepresentable {

    typealias RootView = WeatherView
    
    public var city = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.cityLabel?.text = self.city
        self.rootView?.temperatureLabel?.text = "Loading"
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q="
            + self.city
            + "&units=metric&appid=5372fc075a669c8e7a76effda37c5eb5"
        
        urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed).do {
            URL(string: $0).do {
                let parser = NetworkManager<Weather>()
                parser.loadData(url: $0)
                parser.observer {
                    switch $0 {
                    case .notLoaded: return
                    case .didStartLoading: return
                    case .didLoad:
                        DispatchQueue.main.async {
                            self.rootView?.temperatureLabel?.text = String((parser.model?.main.temp)!)
                        }
                    case .didFailedWithError(let error): print(error)
                    }
                }
            }
        }
    }
}
