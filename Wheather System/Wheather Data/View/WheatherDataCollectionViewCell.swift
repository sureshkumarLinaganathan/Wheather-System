//
//  WheatherDataCollectionViewCell.swift
//  Wheather System
//
//  Created by  Suresh Kumar on 04/12/18.
//  Copyright © 2018 Suresh Kumar. All rights reserved.
//

import UIKit

let WheatherDataCollectionViewCellReuseIdentifier = "WheatherDataCollectionViewCellReuseIdentifier"

class WheatherDataCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var yearLabel: UILabel!
    
    func setupView(metric:Metrics){
        self.yearLabel.text = String(metric.year!)
        setupCardView()
    }
    
    func setupCardView(){
        self.view.alpha = 1.0;
        self.view.layer.masksToBounds = false;
        self.view.layer.cornerRadius = 0;
        self.view.layer.shadowOffset = CGSize(width: 0, height: 0);
        self.view.layer.shadowRadius = 2.0;
        self.view.layer.shadowColor = UIColor.lightGray.cgColor;
        self.view.layer.shadowOpacity = 1.0
    }
}
