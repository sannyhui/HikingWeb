//
//  Map.swift
//  HikingWebPage
//
//  Created by Sanny Hui on 30/7/2022.
//

import Foundation
import MapKit

class Map: NSObject, MKAnnotation{
    var name: String?
    var long: Double?
    var lat: Double?
    var image: String?
    
    init(dict:[String: AnyObject]) {
        if let name = dict["name"] as? String {
            self.name = name
        }
        if let long = dict["long"] as? Double {
            self.long = long
        }
        if let lat = dict["lat"] as? Double {
            self.lat = lat
        }
        if let image = dict["image_url"] as? String {
            self.image = image
        }
    }
    
    var coordinate: CLLocationCoordinate2D {
        guard let long = long, let lat = lat else {return CLLocationCoordinate2D()}
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    var title: String? {
        return name
    }
    
}
