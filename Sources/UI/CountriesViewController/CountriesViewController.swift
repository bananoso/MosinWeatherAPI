//
//  CountriesViewController.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 10.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController, UITableViewDataSource, RootViewRepresentable {
    
    typealias RootView = CountriesView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView?.countriesTable?.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.rootView?.countriesTable?.dequeueReusableCell(withIdentifier: "cellName")
                 ?? UITableViewCell(style: .default, reuseIdentifier: "cellName")
        
        cell.textLabel?.text = "labelText"
        
        return cell
    }
}
