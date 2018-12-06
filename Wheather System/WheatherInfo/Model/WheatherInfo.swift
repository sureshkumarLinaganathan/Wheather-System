//
//  WheatherInfo.swift
//  Wheather System
//
//  Created by  Suresh Kumar on 06/12/18.
//  Copyright © 2018 Suresh Kumar. All rights reserved.
//

import UIKit

class WheatherInfo: NSObject {
    
    var year:Int64?
    var month:Int64?
    var raniFall:Double?
    var maxTemp:Double?
    var minTemp:Double?
    
    func createWheatherInfoObject(rainFalls:[Metrics],maxTemps:[Metrics],minTemps:[Metrics])->[WheatherInfo]{
        
        var objects = [WheatherInfo]()
        for i in stride(from:0, to: 12, by:1){
            
            let rainFall = rainFalls.count>i ? rainFalls[i]: Metrics()
            let wheatherInfo = WheatherInfo()
            wheatherInfo.year = rainFall.year
            wheatherInfo.month = rainFall.month
            wheatherInfo.raniFall = rainFall.value
            
            let maxTemp = maxTemps.count>i ? maxTemps[i]:Metrics()
            wheatherInfo.maxTemp = maxTemp.value
            
            let minTemp = minTemps.count>i ? minTemps[i]:Metrics()
            wheatherInfo.minTemp = minTemp.value
            objects.append(wheatherInfo)
        }
        return objects
    }

}
