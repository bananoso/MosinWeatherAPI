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
    
    private var isFilled = false
    
    private let model: Countries
    private let networkManager: NetworkService
    private let modelObserver = CancellableProperty()
    
    private let cellObserver = CancellableProperty()
        
    public init(model: Countries, networkManager: NetworkService) {
        self.model = model
        self.networkManager = networkManager
        
        super.init(nibName: nil, bundle: nil)
        
        self.modelObserver.value = model.observer { [weak self] in
            if case .didAppend = $0 {
                dispatchOnMain(self?.reloadTable)
            }
        }
        
        self.networkManager.load(countriesModel: model)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.countriesTable?.register(CountryViewCell.self)
        if !self.isFilled {
            self.reloadTable()
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withCellClass: CountryViewCell.self) {
            let country = self.model[indexPath.row]
            $0.country = country
            
            $0.cancellableObserver = country.observer { _ in
                dispatchOnMain {
                    tableView.reloadRow(at: indexPath, with: .none)
                }
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let controller = WeatherViewController()
        controller.networkManager = self.networkManager
        controller.country = self.model[indexPath.row]

        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func reloadTable() {
        self.countriesTable.do {
            dispatchOnMain($0.reloadData)
            self.isFilled = true
        }
    }
}
