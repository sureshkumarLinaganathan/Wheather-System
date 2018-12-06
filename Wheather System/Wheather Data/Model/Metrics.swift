//
//  RainFall.swift
//  Wheather System
//
//  Created by  Suresh Kumar on 04/12/18.
//  Copyright © 2018 Suresh Kumar. All rights reserved.
//

import UIKit

class Metrics: NSObject {
    
    var value:Double?
    var year:Int64?
    var month:Int64?
    
    func initWithArray(array:[NSDictionary])->[Metrics]{
        var objects = [Metrics]()
        for dict in array{
            let metrics = Metrics()
            metrics.value = dict["value"] as? Double
            metrics.year = dict["year"] as? Int64
            metrics.month = dict["month"] as? Int64
            objects.append(metrics)
        }
        return objects
    }
    
}
