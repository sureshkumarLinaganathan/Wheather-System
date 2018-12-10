//
//  Database.swift
//  Wheather System
//
//  Created by Suresh Kumar on 09/12/18.
//  Copyright © 2018 Suresh Kumar. All rights reserved.
//

import UIKit
import CoreData


let RAIN_FALL_KEY = "rainfall"
let MAX_TEMP_KEY = "maxtemp"
let MIN_TEMP = "mintemp"

class Database: NSObject {
    
    static let sharedInstance = Database.init()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        var context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        context.persistentStoreCoordinator = self.psc
        return context
    }()
    
    lazy var psc: NSPersistentStoreCoordinator = {
        //This resource is the same name as your xcdatamodeld contained in your project
        guard let modelURL = Bundle.main.url(forResource: "Database", withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        return psc;
    }()
    
    private override init() {
        super.init();
    }
    
    func initCoreData() {
        guard let docURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            fatalError("Unable to resolve document directory")
        }
        let storeURL = docURL.appendingPathComponent("Database.sqlite")
        do {
            try self.psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
        } catch {
            fatalError("Error migrating store: \(error)")
        }
    }
    
    
}

extension Database{
    
    func saveRainFallToDB(array:[Metrics],countryName:String){
        
        for metric in array{
            
            let rainFall = NSEntityDescription.insertNewObject(forEntityName: "CDRainFall", into: self.managedObjectContext) as! CDRainFall
            
            if let value = metric.value{
                rainFall.value = value
            }
            if let year = metric.year{
                rainFall.year = year
            }
            if let month = metric.month{
                rainFall.month = month
            }
            rainFall.countryName = countryName
            
            do{
                try self.managedObjectContext.save()
            }catch{
                fatalError("Failure to save context: \(error)")
            }
        }
    }
    
    func saveMaxTempToDB(array:[Metrics],countryName:String){
        for metric in array{
            
            let maxTemp = NSEntityDescription.insertNewObject(forEntityName: "CDMaxTemp", into: self.managedObjectContext) as! CDMaxTemp
            
            if let value = metric.value{
                maxTemp.value = value
            }
            if let year = metric.year{
                maxTemp.year = year
            }
            if let month = metric.month{
                maxTemp.month = month
            }
            maxTemp.countryName = countryName
            
            do{
                try self.managedObjectContext.save()
            }catch{
                fatalError("Failure to save context: \(error)")
            }
        }
    }
    
    func saveMinTempToDB(array:[Metrics],countryName:String){
        for metric in array{
            
            let minTemp = NSEntityDescription.insertNewObject(forEntityName: "CDMinTemp", into: self.managedObjectContext) as! CDMinTemp
            
            if let value = metric.value{
                minTemp.value = value
            }
            if let year = metric.year{
                minTemp.year = year
            }
            if let month = metric.month{
                minTemp.month = month
            }
            minTemp.countryName = countryName
            
            do{
                try self.managedObjectContext.save()
            }catch{
                fatalError("Failure to save context: \(error)")
            }
        }
    }
}

extension Database{
    
    func deleteRainFallData(countryName:String){
        let rainfall = CDRainFall.fetchRequest() as NSFetchRequest
        rainfall.predicate = NSPredicate.init(format:"countryName == %@", countryName)
        do{
            
            let rainFalls = try self.managedObjectContext.fetch(rainfall)
            for metric in rainFalls{
                self.managedObjectContext.delete(metric);
            }
            
        }catch{
            print("Failure to save context: \(error)")
        }
        
        do{
            try self.managedObjectContext.save();
        }catch{
            print("Failure to save context: \(error)")
        }
    }
    
    func deleteMaxTempData(countryName:String){
        let maxTemp = CDMaxTemp.fetchRequest() as NSFetchRequest
        maxTemp.predicate = NSPredicate.init(format:"countryName == %@", countryName)
        do{
            
            let maxTemps = try self.managedObjectContext.fetch(maxTemp)
            for metric in maxTemps{
                self.managedObjectContext.delete(metric);
            }
            
        }catch{
            print("Failure to save context: \(error)")
        }
        
        do{
            try self.managedObjectContext.save();
        }catch{
            print("Failure to save context: \(error)")
        }
    }
    func deleteMinTempData(countryName:String){
        let minTemp = CDMinTemp.fetchRequest() as NSFetchRequest
        minTemp.predicate = NSPredicate.init(format:"countryName == %@", countryName)
        do{
            
            let minTemps = try self.managedObjectContext.fetch(minTemp)
            for metric in minTemps{
                self.managedObjectContext.delete(metric);
            }
            
        }catch{
            print("Failure to save context: \(error)")
        }
        
        do{
            try self.managedObjectContext.save();
        }catch{
            print("Failure to save context: \(error)")
        }
    }
}

extension Database{
    
    func fetchRainFallData(countryName:String)->[Metrics]{
        var rainFalls = [CDRainFall]()
        var array = [Metrics]()
        let rainFallRequest = CDRainFall.fetchRequest() as NSFetchRequest
        rainFallRequest.predicate = NSPredicate.init(format:"countryName == %@", countryName)
        do{
            rainFalls  = try self.managedObjectContext.fetch(rainFallRequest)
        }catch{
            print("Failure to save context: \(error)")
        }
        for rainfall in rainFalls {
            let metric = Metrics()
            metric.value = rainfall.value
            metric.year = rainfall.year
            metric.month = rainfall.month
            
            array.append(metric)
        }
        return array
    }
    
    func fetchMaxTempData(countryName:String)->[Metrics]{
        var maxTemps = [CDMaxTemp]()
        var array = [Metrics]()
        let maxTempRequest = CDMaxTemp.fetchRequest() as NSFetchRequest
        maxTempRequest.predicate = NSPredicate.init(format:"countryName == %@", countryName)
        do{
            maxTemps  = try self.managedObjectContext.fetch(maxTempRequest)
        }catch{
            print("Failure to save context: \(error)")
        }
        for maxTemp in maxTemps {
            let metric = Metrics()
            metric.value = maxTemp.value
            metric.year = maxTemp.year
            metric.month = maxTemp.month
            
            array.append(metric)
        }
        return array
    }
    
    func fetchMinTempData(countryName:String)->[Metrics]{
        var minTemps = [CDMinTemp]()
        var array = [Metrics]()
        let minTempRequest = CDMinTemp.fetchRequest() as NSFetchRequest
        minTempRequest.predicate = NSPredicate.init(format:"countryName == %@", countryName)
        do{
            minTemps  = try self.managedObjectContext.fetch(minTempRequest)
        }catch{
            print("Failure to save context: \(error)")
        }
        for minTemp in minTemps {
            let metric = Metrics()
            metric.value = minTemp.value
            metric.year = minTemp.year
            metric.month = minTemp.month
            
            array.append(metric)
        }
        return array
    }
    
}
