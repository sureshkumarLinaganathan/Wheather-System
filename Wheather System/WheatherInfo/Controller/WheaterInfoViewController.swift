//
//  WheaterInfoViewController.swift
//  Wheather System
//
//  Created by  Suresh Kumar on 06/12/18.
//  Copyright © 2018 Suresh Kumar. All rights reserved.
//

import UIKit

let WheaterInfoViewControllerSegue = "WheatherInfoViewControllerSegue"

class WheaterInfoViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var wheatherInfo = [WheatherInfo]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated:true)
    }
}


extension WheaterInfoViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wheatherInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let wheatherInfoCell:WheatherInfoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:WheatherInfoCollectionViewCellReuseIdentifier, for:indexPath) as! WheatherInfoCollectionViewCell
        let obj = wheatherInfo[indexPath.row]
        wheatherInfoCell.setupView(wheatherInfo:obj)
        return wheatherInfoCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = collectionView.frame
        return CGSize(width:screenSize.width - 40, height:screenSize.height-40)
    }
    
}
