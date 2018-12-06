//
//  WheatherDataViewController.swift
//  Wheather System
//
//  Created by  Suresh Kumar on 04/12/18.
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
    var wheatherInfo = [WheatherInfo]()
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
    
    func filterDataFromArray(year:Int64, array:[Metrics])->[Metrics]{
        let filterArray = array.filter {$0.year == year}
        return filterArray
    }
    func sortArray(array:[Metrics])->[Metrics]{
        let sortArray = array.sorted(by:{ $0.month! < $1.month! })
        return sortArray
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == WheaterInfoViewControllerSegue){
            let controller:WheaterInfoViewController = segue.destination as! WheaterInfoViewController
            controller.wheatherInfo = wheatherInfo
        }
    }
    
}

extension WheatherDataViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (rainFalls.count/12)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let wheatherDataCell:WheatherDataCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:WheatherDataCollectionViewCellReuseIdentifier, for:indexPath) as! WheatherDataCollectionViewCell
        let index = indexPath.row * 12
        let metric:Metrics = rainFalls[index]
        wheatherDataCell.setupView(metric:metric)
        return wheatherDataCell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 95, height: 95)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row * 12
        var year:Int64 = 0
        if(index<rainFalls.count){
            let metric = rainFalls[index]
            year = metric.year!
        }
        filterObjects(year:year)
        self.performSegue(withIdentifier:WheaterInfoViewControllerSegue, sender:self)
    }
    
    func filterObjects(year:Int64){
        var filterRainFalls = filterDataFromArray(year:year, array:rainFalls)
        filterRainFalls = sortArray(array:filterRainFalls)
        
        var filterMaxTemp = filterDataFromArray(year:year, array: maxTemp)
        filterMaxTemp = sortArray(array:filterMaxTemp)
        
        var filterMinTemp = filterDataFromArray(year:year, array:minTemp)
        filterMinTemp = sortArray(array:filterMinTemp)
        wheatherInfo = WheatherInfo().createWheatherInfoObject(rainFalls:filterRainFalls, maxTemps:filterMaxTemp, minTemps:filterMinTemp)
        
        
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
                self.collectionView.reloadData()
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
                self.collectionView.reloadData()
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
                self.collectionView.reloadData()
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
