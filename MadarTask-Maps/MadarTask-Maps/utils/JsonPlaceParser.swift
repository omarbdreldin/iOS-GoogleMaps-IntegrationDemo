//
//  JsonPlaceParser.swift
//  MadarTask-Maps
//
//  Created by Admin on 5/24/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

class JsonPlaceParser {
    
    func mapPlaceFrom(dictionary: NSDictionary) -> Place {
        let place = Place()
        
        let geometry = dictionary.value(forKey: "geometry") as! NSDictionary
        let location = geometry.value(forKey: "location") as! NSDictionary
        place.lat = location.value(forKey: "lat") as? Double
        place.long = location.value(forKey: "lng") as? Double
        
        place.name = dictionary.value(forKey: "name") as? String
        place.icon = dictionary.value(forKey: "icon") as? String
        place.vicinity = dictionary.value(forKey: "vicinity") as? String
        place.placeId = dictionary.value(forKey: "place_id") as? String
        
        return place
    }
    
    func getPlacesList(jsonDict: NSDictionary) -> [Place] {
        var placesList = [Place]()
        let placesJsonArray = jsonDict.value(forKey: "results") as! [NSDictionary]
        for placeDict in placesJsonArray {
            let place = mapPlaceFrom(dictionary: placeDict)
            placesList.append(place)
        }
        return placesList
    }
}
