//
//  WheatherDataViewController.swift
//  Wheather System
//
//  Created by Natarajan on 04/12/18.
//  Copyright © 2018 Suresh Kumar. All rights reserved.
//

import UIKit

let MAX_MONTH = 12
let WheatherDataViewControllerSegue = "WheatherDataViewControllerSegue"

class WheatherDataViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedCountryName:String?
    var rainFalls = [Metrics]()
    var maxTemp = [Metrics]()
    var minTemp = [Metrics]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchRainFall(countryName:selectedCountryName!)
        self.fetchMaxTemp(countryName: selectedCountryName!)
        self.fetchMinTemp(countryName: selectedCountryName!)
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated:true)
    }
    
}

extension WheatherDataViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MAX_MONTH
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let wheatherDataCell:WheatherDataCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:WheatherDataCollectionViewCellReuseIdentifier, for:indexPath) as! WheatherDataCollectionViewCell
        return wheatherDataCell
        
    }
    
    
}

extension WheatherDataViewController{
    
    func fetchRainFall(countryName:String){
        ServiceProvider().fetchRainFall(countryName:countryName) { (rainFalls,status,message) in
            if(status == true){
                self.rainFalls = rainFalls as! [Metrics]
            }
        }
    }
    
    func fetchMaxTemp(countryName:String){
        ServiceProvider().fetchMaxTemperature(countryName:countryName) { (maxTepms, status,message) in
            if(status == true){
                self.maxTemp = maxTepms as! [Metrics]
            }
        }
    }
    
    func fetchMinTemp(countryName:String){
        ServiceProvider().fetchMinTemperature(countryName:countryName) { (minTemps,status,message) in
            if(status == true){
                self.minTemp = minTemps as! [Metrics]
            }
        }
    }
}
