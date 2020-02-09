//
//  ViewController.swift
//  Landmarks
//
//  Created by Michael Mackiney on 2/9/20.
//  Copyright © 2020 Michael Mackiney. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var descriptionView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.showsCompass = false
        mapView.pointOfInterestFilter = .excludingAll
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.882056, longitude: -87.627819), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        mapView.region = region
    }


}

