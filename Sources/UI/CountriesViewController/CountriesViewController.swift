//
//  CountriesViewController.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 10.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

fileprivate struct Constant {
    
    static let query = "https://restcountries.eu/rest/v2/all"
    static let errorLoadingCity = "Error loading city"
}

class CountriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, RootViewRepresentable {
    
    typealias RootView = CountriesView
    
    var model = Countries() {
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
        return self.model.values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reusableCell = tableView.dequeueReusableCell(withCellClass: CountryViewCell.self)
        let cell = cast(reusableCell) ?? CountryViewCell()
        cell.fillWithModel(self.model.values[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as? CountryViewCell
        let controller = WeatherViewController()
        controller.city = cell?.labelCapital?.text ?? Constant.errorLoadingCity

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
        URL(string: Constant.query).do {
            NetworkManager<[Country]>().loadData(url: $0) { data in
                data.do {
                    let countriesWithCapital = $0.filter { !$0.capital.isEmpty }
                    self.model = Countries(countriesWithCapital)
                }
            }
        }
    }
}
