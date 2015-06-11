//
//  MapViewController.swift
//  AppCodeSwiftBeginning
//
//  Created by Ahmad Ayman on 4/25/15.
//  Copyright (c) 2015 Ahmad Ayman. All rights reserved.
//

import UIKit
import MapKit


class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    var restaurant:Restaurant!  // To get the location data from the passed restaurant
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self

        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location, completionHandler: { (placemarkers, error) -> Void in
            if error != nil
            {
                println(error)
                return
            }
            
            if placemarkers != nil && placemarkers.count > 0
            {
                let placemarker = placemarkers[0] as CLPlacemark // Get the first one
                let annotation = MKPointAnnotation()            // Create a new object
                annotation.title = self.restaurant.name
                annotation.subtitle = self.restaurant.type
                annotation.coordinate = placemarker.location.coordinate
                self.mapView.showAnnotations([annotation], animated: true)     // Add to map
                self.mapView.selectAnnotation(annotation, animated: true)      // Show the bubble
            }
        })
    }
    
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        if annotation.isKindOfClass(MKUserLocation) { return nil }  // We don't want to change the user current location annontation
        
        // Reuse the annotations view if possible
        let identifier = "MyPin"
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
        
        // If there's no aviable annotation -> annotationView == nil -> create a new one
        if annotationView == nil
        {
            // Create a new annoniationView witht the passed annotation and give it a reusable identifier
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView.canShowCallout = true    // Can show extra infos in the callout buble ?
            annotationView.draggable = true
            
        }
        
        let leftIconView = UIImageView(frame: CGRectMake(0, 0, 53, 53))  // Display the image in the left icon view
        leftIconView.image = UIImage(data: restaurant.image)
        annotationView.leftCalloutAccessoryView = leftIconView

        return annotationView
    }
    
    
}
