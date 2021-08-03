//
//  MapViewController.swift
//  QRCodeReader
//
//  Created by Kunasilan on 26/10/20.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    @IBAction func backToHome(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var mapArray: [signedIn] = []
    var userCoordinate = CLLocation()

    override func viewDidLoad() {
        createAnnotations()
        render(userCoordinate)
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func createAnnotations() {
        for location in mapArray {
            let annotations = MKPointAnnotation()
            annotations.title = location.title
            print(location.title)
            annotations.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            print(annotations.coordinate)
            mapView.addAnnotation(annotations)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationManager.stopUpdatingLocation()
            render(location)
        }
    }
    
    func render(_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.showsUserLocation = true
        mapView.setRegion(region, animated: true)
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
