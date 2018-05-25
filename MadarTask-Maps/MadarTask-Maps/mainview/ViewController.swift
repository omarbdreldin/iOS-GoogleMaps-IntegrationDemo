//
//  ViewController.swift
//  MadarTask-Maps
//
//  Created by Admin on 5/23/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    var mosques: [Place]?
    var banks: [Place]?
    var mapView: GMSMapView?
    var currentLocation: CLLocation?
    var locationManager: CLLocationManager?
    
    @IBOutlet weak var segmentedController: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let camera = GMSCameraPosition.camera(withLatitude: 0, longitude: 0, zoom: 15.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView?.delegate = self
        view = mapView
        
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        print(CLLocationManager.locationServicesEnabled())
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.distanceFilter = kCLHeadingFilterNone
            locationManager?.startUpdatingLocation()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func segmentedContrllerIndexChanged(_ sender: Any) {
        switch segmentedController.selectedSegmentIndex {
        case 0:
            clearMapView()
        case 1:
            addBanksMarkers()
        case 2:
            addMosquesMarkers()
        default:
            break
        }
    }
}

// extension for async callback closures
extension ViewController {
    
    func setPlacesList(placesList: [Place], type: String) {
        
        switch type {
        case "mosque":
            mosques = placesList
        case "bank":
            banks = placesList
        default:
            print(type)
        }
    }
}

// extension for adding markers to mapview
extension ViewController {
    
    func clearMapView() -> Void {
        mapView?.clear()
        updateMapView()
        addCurrentLocationMarker()
    }
    
    func addBanksMarkers() -> Void {
        mapView?.clear()
        addCurrentLocationMarker()
        if banks != nil {
            for bank in banks! {
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: bank.lat!, longitude: bank.long!)
                marker.title = bank.name
                marker.snippet = bank.vicinity
                marker.map = mapView
            }
        }
    }
    
    func addMosquesMarkers() -> Void {
        mapView?.clear()
        addCurrentLocationMarker()
        if mosques != nil {
            for mosque in mosques! {
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: mosque.lat!, longitude: mosque.long!)
                marker.title = mosque.name
                marker.snippet = mosque.vicinity
                marker.map = mapView
            }
        }
    }
}

// extension for mapviewdelgate callbacks
extension ViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        if marker.title != "You are here" {
            let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "routingView") as! DetailViewController
            
            detailViewController.marker = marker
            
            StaticMapImageUrlBuilder().buildUrlfor(currentLat: (currentLocation?.coordinate.latitude)!, currentLong: (currentLocation?.coordinate.longitude)!, destinationLat: marker.position.latitude, destinationLong: marker.position.longitude, onSuccess:{
                imageUrl, distance in
                print(imageUrl)
                detailViewController.imageUrl = imageUrl
                detailViewController.distance = distance
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(detailViewController, animated: true)
                }
            })
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations[0]
        updateMapView()
        addCurrentLocationMarker()
        updateNearbyPlacesLists()
    }
    
    func updateMapView() -> Void {
        let camera = GMSCameraPosition.camera(withLatitude: (currentLocation?.coordinate.latitude)!, longitude: (currentLocation?.coordinate.longitude)!, zoom: 15.0)
        mapView?.camera = camera
        mapView?.animate(to: camera)
    }
    
    func updateNearbyPlacesLists() -> Void {
        NearbyPlacesDownloader().downloadNearbyPlacesFor(lat: (currentLocation?.coordinate.latitude)!, long: (currentLocation?.coordinate.longitude)!, type: "bank", radius: 5000, onSuccess: setPlacesList(placesList:type:))
        
        NearbyPlacesDownloader().downloadNearbyPlacesFor(lat: (currentLocation?.coordinate.latitude)!, long: (currentLocation?.coordinate.longitude)!, type: "mosque", radius: 5000, onSuccess: setPlacesList(placesList:type:))
    }
    
    func addCurrentLocationMarker() -> Void {
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: (currentLocation?.coordinate.latitude)!, longitude: (currentLocation?.coordinate.longitude)!)
        marker.title = "You are here"
        marker.snippet = "what?"
        marker.icon = GMSMarker.markerImage(with: .blue)
        marker.map = mapView
    }
}

