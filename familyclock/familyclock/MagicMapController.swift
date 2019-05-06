//
//  MagicMapController.swift
//  familyclock
//
//  Created by Brad Lee on 5/6/19.
//  Copyright © 2019 Alexis Ferrante. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MagicMapController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAnnotations(people: ["A":CLLocationCoordinate2D(latitude: 37.332, longitude: -122.0111),
                                "B":CLLocationCoordinate2D(latitude: 37.3422, longitude: -122.0256),
                                "C":CLLocationCoordinate2D(latitude: 37.3512, longitude: -122.0056)])
        self.mapView.showAnnotations(self.mapView.annotations, animated: true)
    }
    
    func addAnnotations(people: [String: CLLocationCoordinate2D]) {
        var annotationList: [MKPointAnnotation] = []
        for elem in people {
            let annotation = MKPointAnnotation()
            annotation.title = elem.key
            annotation.coordinate = elem.value
            annotationList.append(annotation)
        }
        mapView.addAnnotations(annotationList)
    }
}
