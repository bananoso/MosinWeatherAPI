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
    
    var model = Countries() {
        didSet {
            DispatchQueue.main.async {
                self.rootView?.countriesTable?.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        URL(string: "https://restcountries.eu/rest/v2/all").do {
            let parser = NetworkManager<[Country]>()
            parser.loadData(url: $0)
            parser.observer {
                switch $0 {
                case .notLoaded: return
                case .didStartLoading: return
                case .didLoad: self.model = Countries(parser.model!)
                case .didFailedWithError(let error): print(error)
                }
            }
        }
        
        self.rootView?.countriesTable?.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellClass = CountryViewCell.self

        let getCell: () -> CountryViewCell? = {
            let nib = UINib(cellClass)
            let cells = nib.instantiate(withOwner: nil, options: nil) as? [CountryViewCell]
            let cell = cells?.first
            cell?.fillWithModel(self.model.values[indexPath.row])

            return cell
        }

        let cell = cast(tableView.dequeueReusableCell(withCellClass: cellClass)) ?? getCell()

        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath) as? CountryViewCell
        let controller = WeatherViewController()
        controller.city = cell?.labelCapital?.text ?? ""

        self.navigationController?.pushViewController(controller, animated: true)
    }
}
