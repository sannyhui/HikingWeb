//
//  Item3.swift
//  HikingWebPage
//
//  Created by Sanny Hui on 30/7/2022.
//

import UIKit
import MapKit

class Item3: UIViewController {
    
    let manager = MapManager()
    var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "地圖"
        manager.fetch()
        mapView = MKMapView()
        mapView.delegate = self
        mapView.frame = CGRect(x: 0, y: 95, width: view.bounds.width, height: view.bounds.height - 180)
        view.addSubview(mapView)
        addRegion()
    }
    
    func addRegion() {
        mapView.setRegion(manager.currentRegion(latDelta: 0.3, longDelta: 0.3), animated: true)
        mapView.addAnnotations(manager.mapItems)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let item = sender as? Map else {return}
        if segue.identifier == Item3Details.segueID {
            if let vc = segue.destination as? Item3Details {
                vc.selectedItem = item
            }
        }
    }

}

extension Item3: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {return nil}
        var annotationView: MKAnnotationView?
        if let item = mapView.dequeueReusableAnnotationView(withIdentifier: "mapID") {
            annotationView = item
            annotationView?.annotation = annotation
        } else {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "mapID")
            annotationView?.image = UIImage(named: "custom-annotation")
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure, primaryAction: nil)
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        performSegue(withIdentifier: Item3Details.segueID, sender: mapView.selectedAnnotations.first)
    }
}
