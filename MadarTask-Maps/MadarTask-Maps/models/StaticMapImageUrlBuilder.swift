//
//  StaicMapImageUrlBuilder.swift
//  MadarTask-Maps
//
//  Created by Admin on 5/24/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Alamofire

class StaticMapImageUrlBuilder {

    func buildUrlfor(currentLat: Double, currentLong: Double, destinationLat: Double, destinationLong: Double, onSuccess: @escaping (String, String)->Void) -> Void {
        
        let directionsUrlDrive = "https://maps.googleapis.com/maps/api/directions/json?origin=\(currentLat),\(currentLong)&destination=\(destinationLat),\(destinationLong)&mode=driving&key=\(GoogleApi.API_KEY)"
        
        let directionUrlWalk = "https://maps.googleapis.com/maps/api/directions/json?origin=\(currentLat),\(currentLong)&destination=\(destinationLat),\(destinationLong)&mode=walking&key=\(GoogleApi.API_KEY)"
        
        Alamofire.request(directionsUrlDrive).responseJSON { response in
            //to get JSON return value
            if let result = response.result.value {
                let json = result as! NSDictionary
                
                let tupleDrive = JsonDirectionParser().getPolylineAndDistance(jsonDictionary: json)
                
                Alamofire.request(directionUrlWalk).responseJSON { response in
                    //to get JSON return value
                    if let result = response.result.value {
                        let json = result as! NSDictionary
                        
                        let tupleWalk = JsonDirectionParser().getPolylineAndDistance(jsonDictionary: json)
                        
                        let mapImageUrl = "https://maps.googleapis.com/maps/api/staticmap?size=375x692&path=color:0xff0000ff|weight:5|enc:\(tupleDrive.0)&path=color:0x008000|weight:5|enc:\(tupleWalk.0)&key=\(GoogleApi.API_KEY)"
                        
                        onSuccess(mapImageUrl, tupleDrive.1)
                    }
                    
                }
            }
            
        }
    }
}
