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
        
//        let defaults = UserDefaults.standard
//        if let savedFavorites = defaults.object(forKey: "favorites") as? Data {
//            if let decodedFavorites = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedFavorites) as? [Place] {
//                favorites = decodedFavorites
//            }
//        }
        
        mapView.delegate = self

        mapView.showsCompass = false
        mapView.pointOfInterestFilter = .excludingAll
        
        decodeData()
        displayView.titleView.text = annotations[0].name
        displayView.descriptionView.text = annotations[0].longDescription
        let region = MKCoordinateRegion(center: annotations[0].coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        currentAnnotation = annotations[0]
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
        } else {
            currentAnnotation?.favorite = false
            for i in 0..<favorites.count {
                if favorites[i].name == currentAnnotation!.name {
                    favorites.remove(at: i)
                    break
                }
            }
        }
        // DataManager.sharedInstance.saveFavorites(places: favorites)
        button.isSelected = currentAnnotation!.favorite
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
        return annotationView
    }
}

extension MapViewController: PlacesFavoritesDelegate {
    func favoritePlace(name: String) {
        self.placeTitle = name
        for annotation in annotations {
            if annotation.name == name {
                currentAnnotation = annotation
                displayView.titleView.text = annotation.name
                displayView.descriptionView.text = annotation.longDescription
                displayView.favoriteView.isSelected = annotation.favorite
                let region = MKCoordinateRegion(center: annotation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
                mapView.region = region
            }
        }
    }
}
