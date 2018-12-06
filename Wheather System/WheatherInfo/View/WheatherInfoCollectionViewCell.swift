//
//  WheatherInfoCollectionViewCell.swift
//  Wheather System
//
//  Created by  Suresh Kumar on 06/12/18.
//  Copyright © 2018 Suresh Kumar. All rights reserved.
//

import UIKit

let WheatherInfoCollectionViewCellReuseIdentifier = "WheatherInfoCollectionViewCellReuseIdentifier"

class WheatherInfoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var wheatherView: UIView!
    @IBOutlet weak var rainFallView: UIView!
    @IBOutlet weak var rainFallTextLabel: UILabel!
    @IBOutlet weak var maxTempView: UIView!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var minTempView: UIView!
    
    
    func setupView(wheatherInfo:WheatherInfo){
        createCardView(cardView:cardView)
        createCardView(cardView:rainFallView)
        createCardView(cardView:maxTempView)
        createCardView(cardView: minTempView)
        self.setMonth(month:wheatherInfo.month!)
        rainFallTextLabel.text = wheatherInfo.raniFall == nil ? "N/A" :String(wheatherInfo.raniFall!)+"mm"
        maxTempLabel.text = wheatherInfo.maxTemp == nil ? "N/A" : String(wheatherInfo.maxTemp!) + "°C"
        minTempLabel.text = wheatherInfo.minTemp == nil ? "N/A" :  String(wheatherInfo.minTemp!) + "°C"
    }
    
    func setMonth(month:Int64){
        
        switch month {
        case 1:
            monthLabel.text = "January"
        case 2:
            monthLabel.text = "February"
        case 3:
            monthLabel.text = "March"
        case 4:
            monthLabel.text = "April"
        case 5:
            monthLabel.text = "May"
        case 6:
            monthLabel.text = "June"
        case 7:
            monthLabel.text = "July"
        case 8:
            monthLabel.text = "August"
        case 9:
            monthLabel.text = "September"
        case 10:
            monthLabel.text = "October"
        case 11:
            monthLabel.text = "November"
        default:
            monthLabel.text = "December"
        }
        
    }
    
    func createCardView(cardView:UIView){
        cardView.alpha = 1.0;
        cardView.layer.masksToBounds = false;
        cardView.layer.cornerRadius = 0;
        cardView.layer.shadowOffset = CGSize(width: 0, height: 0);
        cardView.layer.shadowRadius = 2.0;
        cardView.layer.shadowColor = UIColor.lightGray.cgColor;
        cardView.layer.shadowOpacity = 1.0
    }
    
}
