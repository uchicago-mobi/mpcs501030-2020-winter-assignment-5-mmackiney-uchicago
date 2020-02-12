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
    
    let id = MKMapViewDefaultAnnotationViewReuseIdentifier
    var annotations = [Place]()
    var placeTitle: String?
    var favorites = [Place]()
    var currentAnnotation: Place?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self

        mapView.showsCompass = false
        mapView.pointOfInterestFilter = .excludingAll
        
        decodeData()
        displayView.titleView.text = annotations[1].name
        displayView.descriptionView.text = annotations[1].longDescription
        let region = MKCoordinateRegion(center: annotations[1].coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        currentAnnotation = annotations[1]
        mapView.region = region
        
        displayView.favoriteView.addTarget(self,
        action: #selector(buttonTapped),
        for: .touchUpInside)
        
    }
    
    func decodeData() {
        let path = URL(fileURLWithPath: Bundle.main.path(forResource: "Data", ofType: "plist")!)
        var locations: LocationData
        
        let data = try! Data(contentsOf: path)
        let decoder = PropertyListDecoder()
        locations = try! decoder.decode(LocationData.self, from: data)
        for location in locations.places {
            let annotation = Place()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.lat, longitude: location.long)
            annotation.name = location.name
            annotation.longDescription = location.description
            annotations.append(annotation)
            mapView.addAnnotation(annotation)
        }
    }
    
    @objc func buttonTapped(_ button: UIButton) {
        if !currentAnnotation!.favorite {
            currentAnnotation?.favorite = true
            favorites.append(currentAnnotation!)
            print("added")
        } else {
            currentAnnotation?.favorite = false
            print("nothing")
        }
        button.isSelected = currentAnnotation!.favorite
        print(favorites)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! FavoritesViewController
        destination.annotations = self.favorites
        destination.delegate = self
    }
    
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let customAnnotation = view.annotation as? Place {
            displayView.titleView.text = customAnnotation.name
            displayView.descriptionView.text = customAnnotation.longDescription
            displayView.favoriteView.isSelected = customAnnotation.favorite
            currentAnnotation = view.annotation as? Place
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = PlaceMarkerView()
        print(type(of: annotationView))
        return annotationView
    }
}

extension MapViewController: PlacesFavoritesDelegate {
    func favoritePlace(name: String) {
        self.placeTitle = name
        for annotation in annotations {
            if annotation.name == name {
                displayView.titleView.text = annotation.name
                displayView.descriptionView.text = annotation.longDescription
                displayView.favoriteView.isSelected = annotation.favorite
                let region = MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
                mapView.region = region
            }
        }
    }
}
