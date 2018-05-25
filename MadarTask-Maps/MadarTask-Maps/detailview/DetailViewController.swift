//
//  DetailViewController.swift
//  MadarTask-Maps
//
//  Created by Admin on 5/24/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import UIKit
//import SDWebImage
import Kingfisher
import GoogleMaps

class DetailViewController: UIViewController {
    
    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var staticMapImage: UIImageView!
    
    var imageUrl: String?
    var distance: String?
    var marker: GMSMarker?
    
    override func viewDidLoad() {
        view.setNeedsDisplay()
        
        staticMapImage.image = UIImage(named: "dummy.png")
        
        staticMapImage.kf.indicatorType = .activity
        staticMapImage.kf.setImage(with: URL(string: imageUrl!))
//        staticMapImage.sd_setImage(with: URL(string: imageUrl!), completed: nil)
        infoTextView.text = "\(marker!.title!)\n\(marker!.snippet!)\nDistance: \(distance!)"
    }
}
