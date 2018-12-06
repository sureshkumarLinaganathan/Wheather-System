//
//  CountryListTableViewCell.swift
//  Wheather System
//
//  Created by  Suresh Kumar on 03/12/18.
//  Copyright © 2018 Suresh Kumar. All rights reserved.
//

import UIKit

let CountryListTableViewCellReuseIdentifier = "CountryListTableViewCellReuseIdentifier"

class CountryListTableViewCell: UITableViewCell {
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var countryLogo: UIImageView!
    
    func setupView(country:Country){
       
        self.countryName.text = country.name
        self.countryLogo.image = UIImage.init(named:country.logoName!)
    }
}
