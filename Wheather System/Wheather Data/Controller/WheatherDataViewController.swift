//
//  WheatherDataViewController.swift
//  Wheather System
//
//  Created by Natarajan on 04/12/18.
//  Copyright © 2018 Suresh Kumar. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

let MAX_MONTH = 12
let WheatherDataViewControllerSegue = "WheatherDataViewControllerSegue"
let MAX_PROCESS_COUNT = 3

class WheatherDataViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var selectedCountryName:String?
    var rainFalls = [Metrics]()
    var maxTemp = [Metrics]()
    var minTemp = [Metrics]()
    var count = 0
    
    var loadingIndicator:NVActivityIndicatorView?
    var loadingView:UIView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        addLoadingIndicator()
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
        showLoadingIndicator()
        ServiceProvider().fetchRainFall(countryName:countryName) { [unowned self] (rainFalls,status,message) in
            self.count = self.count+1
            if(status == true){
                self.rainFalls = rainFalls as! [Metrics]
            }
            if(self.count == MAX_PROCESS_COUNT){
                self.hideLoadingIndicator()
            }
        }
    }
    
    func fetchMaxTemp(countryName:String){
        ServiceProvider().fetchMaxTemperature(countryName:countryName) { [unowned self] (maxTepms, status,message) in
            self.count = self.count+1
            if(status == true){
                self.maxTemp = maxTepms as! [Metrics]
            }
            if(self.count == MAX_PROCESS_COUNT){
                self.hideLoadingIndicator()
            }
        }
    }
    
    func fetchMinTemp(countryName:String){
        ServiceProvider().fetchMinTemperature(countryName:countryName) { [unowned self] (minTemps,status,message) in
            self.count = self.count+1
            if(status == true){
                self.minTemp = minTemps as! [Metrics]
            }
            if(self.count == MAX_PROCESS_COUNT){
                self.hideLoadingIndicator()
            }
        }
    }
}

extension WheatherDataViewController{
    
    func addLoadingIndicator(){
        self.loadingView = UIView.init(frame: self.view.frame);
        self.loadingView?.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.loadingView?.isUserInteractionEnabled = false;
        self.loadingIndicator = NVActivityIndicatorView.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50), type: .ballSpinFadeLoader, color: UIColor.orange, padding: 0)
        self.loadingIndicator?.center = (self.loadingView?.center)!;
        self.loadingView?.addSubview(self.loadingIndicator!);
        self.view.addSubview(self.loadingView!);
        self.loadingView?.isHidden = true;
        self.loadingView?.bringSubviewToFront(self.loadingIndicator!);
        self.view?.bringSubviewToFront(self.loadingView!)
    }
    
    func showLoadingIndicator(){
        self.loadingView?.isHidden = false;
        self.loadingIndicator?.startAnimating()
        self.view.isUserInteractionEnabled = false
    }
    
    func hideLoadingIndicator(){
        self.loadingView?.isHidden = true;
        self.loadingIndicator?.stopAnimating()
        self.view.isUserInteractionEnabled = true
    }
}
