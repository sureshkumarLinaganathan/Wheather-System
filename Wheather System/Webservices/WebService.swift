//
//  WebService.swift
//  Wheather System
//
//  Created by Natarajan on 04/12/18.
//  Copyright © 2018 Suresh Kumar. All rights reserved.
//

import UIKit

class WebService: NSObject {
    
    func initWithGETUrl(urlString:String,callback:@escaping (_ array:NSArray,_ status:Bool,_ message:String)->Void){
        
        let url:URL = URL.init(string:urlString)!
        var request:URLRequest = URLRequest.init(url:url)
        request.httpMethod = "Get"
        let configuration = URLSessionConfiguration.default;
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main);
        let task = session.dataTask(with: request) { (data, response,error) in
            do {
                var array = [NSDictionary]()
                if let httpResponse = response as? HTTPURLResponse{
                    if( (httpResponse.statusCode == 200)&&(data?.count != 0 && error == nil)){
                        let jsonObject:NSArray = try JSONSerialization.jsonObject(with: data!, options:.mutableLeaves) as! NSArray;
                        array = jsonObject as! [NSDictionary]
                        DispatchQueue.main.async {
                            callback(array as NSArray,true,"")
                        }
                    }else {
                        DispatchQueue.main.async {
                            callback(array as NSArray,false,"");
                        }
                    }
                    
                }else {
                    if let errorObj:NSError = error as NSError?{
                        DispatchQueue.main.async {
                            callback(array as NSArray, false,errorObj.localizedDescription);
                        }
                    }
                }
            }catch let error as NSError {
                let array = [NSDictionary]()
                DispatchQueue.main.async {
                    callback(array as NSArray,false, error.localizedDescription);
                }
            }
            
        }
        task.resume()
        
    }
}
