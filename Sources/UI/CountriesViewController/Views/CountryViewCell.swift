//
//  CountryViewCell.swift
//  WeatherAPI
//
//  Created by Mosin Dmitry on 10.01.2019.
//  Copyright © 2019 IDAP. All rights reserved.
//

import UIKit

class CountryViewCell: TableViewCell {

    @IBOutlet var label1: UILabel?
    @IBOutlet var label2: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fillWithModel(_ country: Country){
        self.label1?.text = country.name
    }
    
}
