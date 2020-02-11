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
        
        let path = URL(fileURLWithPath: Bundle.main.path(forResource: "Data", ofType: "plist")!)
        var locations: LocationData
        
        let data = try! Data(contentsOf: path)
        let decoder = PropertyListDecoder()
        locations = try! decoder.decode(LocationData.self, from: data)
        for location in locations.places {
            let annotation = Place()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.lat, longitude: location.long)
            annotation.title = location.name
            annotation.longDescription = location.description
            mapView.addAnnotation(annotation)
        }
        
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
