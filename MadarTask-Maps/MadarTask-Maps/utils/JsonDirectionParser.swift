//
//  JsonDirectionParser.swift
//  MadarTask-Maps
//
//  Created by Admin on 5/24/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class JsonDirectionParser {
    
    func getPolylineAndDistance(jsonDictionary: NSDictionary) -> (String, String) {
        
        let routes = jsonDictionary.value(forKey: "routes") as! [NSDictionary]
        let jsonObject1 = routes[0]
        let overviewPolylines = jsonObject1.value(forKey: "overview_polyline") as! NSDictionary
        
        let points = overviewPolylines.value(forKey: "points") as! String
        
        let legs = jsonObject1.value(forKey: "legs") as! [NSDictionary]
        let jsonObject2 = legs[0]
        
        let distanceJsonObject = jsonObject2.value(forKey: "distance") as! NSDictionary
        
        let distance = distanceJsonObject.value(forKey: "text") as! String
        
        return (points, distance)
    }
}
