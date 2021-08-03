//
//  signedIn.swift
//  QRCodeReader
//
//  Created by Kunasilan on 19/10/20.
//  Copyright © 2020 Kunasilan. All rights reserved.
//

import Foundation
import CoreLocation

import UIKit

class signedIn {
    
//    var image: UIImage
    var url: String
    var title: String
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    
    init(url: String, title: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
//        self.image = image
        self.url = url
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
    }
    
}
