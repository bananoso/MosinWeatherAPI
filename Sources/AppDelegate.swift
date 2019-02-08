//
//  AppDelegate.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 09.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    )
        -> Bool
    {
        let requestService = RequestServiceImpl(session: .shared)
        let networkManager = NetworkManager(requestService: requestService)
        let countriesViewController = CountriesViewController(model: .init())
        countriesViewController.networkManager = networkManager
        
        let navigationController = UINavigationController(rootViewController: countriesViewController)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window

        return true
    }
}

