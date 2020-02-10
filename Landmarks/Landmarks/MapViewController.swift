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
    @IBOutlet var displayView: DisplayView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self

        mapView.showsCompass = false
        mapView.pointOfInterestFilter = .excludingAll
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 41.882056, longitude: -87.627819), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        mapView.region = region
        
        displayView.titleView.text = "Hello"
        displayView.descriptionView.text = "This is a description"
        displayView.favoriteView.isSelected = true
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        displayView.titleView.text = (view.annotation?.title)!
        displayView.descriptionView.text = (view.annotation?.subtitle)!
    }
}

extension MapViewController: PlacesFavoritesDelegate {
  func favoritePlace(name: String) {
   // Update the map view based on the favorite
   // place that was passed in
  }
}
