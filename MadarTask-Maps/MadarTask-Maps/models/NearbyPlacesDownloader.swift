//
//  NearbyPlacesDownloader.swift
//  MadarTask-Maps
//
//  Created by Admin on 5/24/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

struct GoogleApi {
    static let API_KEY = "AIzaSyBlMeAwZhpdc1lUGINq2CeiSb_OTEA-QcA"
}

class NearbyPlacesDownloader {
    
    func downloadNearbyPlacesFor(lat: CLLocationDegrees, long: CLLocationDegrees, type: String, radius: Int, onSuccess: @escaping ([Place], String)-> Void) -> Void {
        
        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(lat),\(long)&radius=\(radius)&type=\(type)&key=\(GoogleApi.API_KEY)"
        
        Alamofire.request(urlString).responseJSON { response in
                //to get JSON return value
                if let result = response.result.value {
                    let json = result as! NSDictionary
                    let placesList = JsonPlaceParser().getPlacesList(jsonDict: json)
                    onSuccess(placesList, type)
                }
                
        }
    }
}
