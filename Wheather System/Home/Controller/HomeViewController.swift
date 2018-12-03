//
//  ViewController.swift
//  Wheather System
//
//  Created by Suresh Kumar on 02/12/18.
//  Copyright © 2018 Suresh Kumar. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var countries:Array = [Country]()
    var selectedCountryName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    func setupView(){
        createCountryObject()
        self.tableView.reloadData()
    }
    
    func createCountryObject(){
        var country = Country()
        country.name = "UK"
        country.logoName = "UK"
        countries.append(country)
        
        country = Country()
        country.name = "England"
        country.logoName = "England"
        countries.append(country)
        
        country = Country()
        country.name = "Scotland"
        country.logoName = "Scotland"
        countries.append(country)
        
        country = Country()
        country.name = "Wales"
        country.logoName = "Wales"
        countries.append(country)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == WheatherDataViewControllerSegue){
            let controller:WheatherDataViewController = segue.destination as! WheatherDataViewController
            controller.selectedCountryName = selectedCountryName
        }
    }
    
}

extension HomeViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let countryListCell:CountryListTableViewCell = tableView.dequeueReusableCell(withIdentifier:CountryListTableViewCellReuseIdentifier, for: indexPath) as! CountryListTableViewCell
        countryListCell.setupView(country: countries[indexPath.row])
        return countryListCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountry = countries[indexPath.row]
        selectedCountryName = selectedCountry.name
        self.performSegue(withIdentifier:WheatherDataViewControllerSegue, sender:self)
    }
    
}

