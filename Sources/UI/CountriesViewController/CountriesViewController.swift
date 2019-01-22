//
//  CountriesViewController.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 10.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

fileprivate struct Strings {
    
    static let query = "https://restcountries.eu/rest/v2/all"
}

class CountriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, RootViewRepresentable {
    
    typealias RootView = CountriesView
    
    var model = [CountryData]() {
        didSet {
            DispatchQueue.main.async {
                self.rootView?.countriesTable?.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareTableView()
        self.prepareCountriesInfo()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableCell = tableView.dequeueReusableCell(withCellClass: CountryViewCell.self)
        let cell = reusableCell ?? CountryViewCell()
        cell.fillWithModel(self.model[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    
        let controller = WeatherViewController()
        controller.onDownloadedWeatherHandler = { [weak self] weather in
            self?.model[indexPath.row].weather = weather
            
            DispatchQueue.main.async {
                self?.rootView?.countriesTable?.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        
        controller.countryData = self.model[indexPath.row]

        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func prepareTableView() {
        self.rootView?.countriesTable.do {
            $0.register(CountryViewCell.self)
            $0.dataSource = self
            $0.delegate = self
        }
    }
    
    private func prepareCountriesInfo() {
        NetworkManager<[Country]>().loadData(query: Strings.query) {
            $0.do {
                self.model = $0.filter { !$0.capital.isEmpty }
                    .map(CountryData.init)
            }
        }
    }
}
