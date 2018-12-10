//
//  ServiceProvider.swift
//  Wheather System
//
//  Created by Suresh Kumar on 04/12/18.
//  Copyright © 2018 Suresh Kumar. All rights reserved.
//

import UIKit

class ServiceProvider: NSObject {
    
    let HOST_URL = "https://s3.eu-west-2.amazonaws.com/interview-question-data/metoffice/"
    let RAINFALL_KEY = "Rainfall"
    let JSON_KEY = "json"
    let MAX_TEMP_KEY = "Tmax"
    let MIN_TEMP_KEY = "Tmin"
    
    let HYBINE_KEY = "-"
    let DOT_KEY = "."
    
    func fetchRainFall(countryName:String ,callback:@escaping (_ array:NSArray,_ status:Bool,_ message:String)->Void){
        
        let urlString = HOST_URL+RAINFALL_KEY+HYBINE_KEY+countryName+DOT_KEY+JSON_KEY
        WebService().initWithGETUrl(urlString:urlString) { (metrics,status,message) in
            var  array = [Metrics]()
            if(status == true){
                array = Metrics().initWithArray(array:metrics as! [NSDictionary]);
                Database.sharedInstance.deleteRainFallData(countryName:countryName)
                Database.sharedInstance.saveRainFallToDB(array:array,countryName:countryName)
            }
            callback(array as NSArray,status,message)
        }
        
        
    }
    
    func fetchMaxTemperature(countryName:String ,callback:@escaping (_ array:NSArray,_ status:Bool,_ message:String)->Void){
        
        let urlString = HOST_URL+MAX_TEMP_KEY+HYBINE_KEY+countryName+DOT_KEY+JSON_KEY
        WebService().initWithGETUrl(urlString:urlString) { (metrics,status,message) in
            var  array = [Metrics]()
            if(status == true){
                array = Metrics().initWithArray(array:metrics as! [NSDictionary]);
                Database.sharedInstance.deleteMaxTempData(countryName:countryName)
                Database.sharedInstance.saveMaxTempToDB(array: array,countryName:countryName)
            }
            callback(array as NSArray,status,message)
        }
        
        
    }
    
    func fetchMinTemperature(countryName:String ,callback:@escaping (_ array:NSArray,_ status:Bool,_ message:String)->Void){
        
        let urlString = HOST_URL+MIN_TEMP_KEY+HYBINE_KEY+countryName+DOT_KEY+JSON_KEY
        WebService().initWithGETUrl(urlString:urlString) { (metrics,status,message) in
            var  array = [Metrics]()
            if(status == true){
                array = Metrics().initWithArray(array:metrics as! [NSDictionary]);
                Database.sharedInstance.deleteMinTempData(countryName:countryName)
                Database.sharedInstance.saveMinTempToDB(array:array,countryName:countryName)
            }
            callback(array as NSArray,status,message)
        }
        
        
    }
    
}
