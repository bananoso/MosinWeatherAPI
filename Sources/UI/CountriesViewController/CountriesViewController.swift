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

    private var countriesTable: UITableView? {
        return self.rootView?.countriesTable
    }
    
    private let model = Countries()
    private let modelObserver = CancellableProperty()
    private let cellObserver = CancellableProperty()
    public var networkManager: NetworkManager?
        
    public init() {
        super.init(nibName: nil, bundle: nil)
        
        self.modelObserver.value = self.model.observer {
            if case .add(_) = $0 {
                dispatchOnMain(self.countriesTable?.reloadData)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.countriesTable?.register(CountryViewCell.self)
        self.networkManager?.loadCountries(self.model.append)
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

        let model = self.model[indexPath.row]
        self.cellObserver.value = model.observer { _ in
            dispatchOnMain {
                self.countriesTable?.reloadRow(at: indexPath, with: .none)
            }
        }
        
        let controller = WeatherViewController()
        controller.networkManager = self.networkManager
        controller.country = model
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
