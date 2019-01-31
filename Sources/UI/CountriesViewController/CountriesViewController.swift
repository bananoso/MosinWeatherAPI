//
//  CountriesViewController.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 10.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, RootViewRepresentable {
    
    typealias RootView = CountriesView
    
    private var model = CountriesData() {
        didSet {
            dispatchOnMain(self.countriesTable?.reloadData)
        }
    }
    
    private var countriesTable: UITableView? {
        return self.rootView?.countriesTable
    }

    private var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareTableView()
        self.prepareCountriesInfo()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withCellClass: CountryViewCell.self) {
            $0.fill(with: self.model[indexPath.row])
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedIndexPath = indexPath
        
        let controller = WeatherViewController()
        controller.countryData = self.model[indexPath.row]

        self.navigationController?.pushViewController(controller, animated: true)
    }
        
    private func prepareTableView() {
        self.countriesTable?.register(CountryViewCell.self)
    }
    
    private func prepareCountriesInfo() {
        CountryManager().loadCountries {
            let data = CountriesData(countries: $0)
            data.observer { [weak self] _ in
                dispatchOnMain {
                    self?.selectedIndexPath.do {
                        self?.countriesTable?.reloadRow(at: $0, with: .none)
                    }
                }
            }
            
            self.model = data
        }
    }
}
