//
//  MapManager.swift
//  HikingWebPage
//
//  Created by Sanny Hui on 30/7/2022.
//

import Foundation
import MapKit

class MapManager {
    var mapItems: [Map] = []
    
    func loadData() -> [[String: AnyObject]] {
        guard let path = Bundle.main.path(forResource: "MapLocations", ofType: "plist"), let data = NSArray(contentsOfFile: path) else {return [[:]]}
        return data as! [[String: AnyObject]]
    }
    
    func fetch() {
        for i in loadData() {
            mapItems.append(Map(dict: i))
        }
    }
    
    func currentRegion(latDelta: CLLocationDegrees, longDelta: CLLocationDegrees) -> MKCoordinateRegion {
        guard let item = mapItems.first else {return MKCoordinateRegion()}
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        return MKCoordinateRegion(center: item.coordinate, span: span)
    }
}
