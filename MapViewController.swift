//
//  MapViewController.swift
//  weatherApp
//
//  Created by Ethan  Jin  on 21/2/2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var myMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lat = cities[selectedRow].latitude
        let long = cities[selectedRow].longitude
        
        let place = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        var mapRegion = MKCoordinateRegion() //A rectangular geographic region centered around a specific latitude and longitude.
        let mapRegionSpan = 1.02
        
        mapRegion.center = place
        mapRegion.span.latitudeDelta = mapRegionSpan
        mapRegion.span.longitudeDelta = mapRegionSpan
        
        myMap.mapType = .hybridFlyover
        
        let camera = MKMapCamera(lookingAtCenter: place, fromDistance: 450000, pitch: 30, heading: 262)
        
        myMap.camera = camera
        
        // create map annotation
        
        let placeAnnotation = MKPointAnnotation()
        placeAnnotation.coordinate = place
        placeAnnotation.title = cities[selectedRow].city
        myMap.addAnnotation(placeAnnotation)
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
