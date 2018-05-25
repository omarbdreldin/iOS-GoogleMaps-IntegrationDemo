//
//  RoutingViewController.swift
//  MadarTask-Maps
//
//  Created by Admin on 5/24/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import GoogleMaps
//import SDWebImage
import Kingfisher

class RoutingViewController: UIViewController {
    
    var marker: GMSMarker?
    var imageUrl: String?
    
    @IBOutlet weak var staticMapImage: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        view.setNeedsDisplay()
        
//        StaticMapImageUrlBuilder().buildUrlfor(currentLat: -33.86, currentLong: 151.20, destinationLat: (marker?.position.latitude)!, destinationLong: (marker?.position.longitude)!, onSuccess: reloadViewWith(imageUrl:distance:))
//        staticMapImage.sd_setImage(with: URL(string: imageUrl!), completed: nil)
        staticMapImage.kf.setImage(with: URL(string: imageUrl!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension RoutingViewController {
    
    func reloadViewWith(imageUrl: String, distance: String) -> Void {
        let url = URL(string: imageUrl)
//        staticImageMap.kf.indicatorType = .activity
//        staticImageMap.kf.setImage(with: url)
        print(distance)
        print(imageUrl)
        if Thread.isMainThread {
            print("In main thread")
        }
        if staticMapImage == nil {
            print("nil image")
        }
//        DispatchQueue.main.async {
//            self.staticMapImage.sd_setImage(with: url, completed: nil)
//            self.view.setNeedsDisplay()
//        }
    }
}
