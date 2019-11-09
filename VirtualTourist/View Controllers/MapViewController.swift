//
//  ViewController.swift
//  VirtualTourist
//
//  Created by Glenn Cole on 10/14/19.
//  Copyright © 2019 Glenn Cole. All rights reserved.
//

import UIKit
import MapKit

enum PinMode {
    case add, remove
}

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var longPressRecognizer: UILongPressGestureRecognizer!
    var inLongPress = false
    var pinMode = PinMode.add

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.title = AppDelegate.NavigationConstants.appName
        setInitialMapView()
        mapView.delegate = self
        
        prepareToAddPins()
    }

    private func setInitialMapView() {
//        let centerCoordinate = UserDefaults.standard.value(forKey: AppDelegate.UserDefaultKeys.mapCenter) as! CLLocationCoordinate2D
//        let mapSpan = UserDefaults.standard.value(forKey: AppDelegate.UserDefaultKeys.mapSpan) as! MKCoordinateSpan
//
//        let region = MKCoordinateRegion( center: centerCoordinate, span: mapSpan)
        
        let mapRegionUtil = MapRegionUtil()
        let region = mapRegionUtil.region
        mapView.setRegion(region, animated: true)
    }
}

extension MapViewController: MKMapViewDelegate
{
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let region = mapView.region
        print( "regionDidChange: center=\(region.center.latitude), \(region.center.longitude)" )
//        let centerCoordinate = region.center
//        let mapSpan = region.span

        let mapRegionUtil = MapRegionUtil(region: region)
        mapRegionUtil.saveAsDefault()
        
//        UserDefaults.standard.set(centerCoordinate, forKey: AppDelegate.UserDefaultKeys.mapCenter)
//        UserDefaults.standard.set(mapSpan, forKey: AppDelegate.UserDefaultKeys.mapSpan)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseID = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
        }
        pinView?.animatesDrop = true
        
        return pinView
    }
}

// MARK: - user drop pins on map

// https://stackoverflow.com/questions/30858360/adding-a-pin-annotation-to-a-map-view-on-a-long-press-in-swift#31304290
// https://stackoverflow.com/questions/38599534/how-to-make-map-pins-animate-drop-swift-2-2-ios-9#38638863

extension MapViewController
{
    func prepareToAddPins() {
        
        pinMode = .add
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                                            target: self,
                                                            action: #selector(enterPinRemovalMode(_:)))
        setupDropPinGesture()
    }
    
    func setupDropPinGesture() {

        if longPressRecognizer == nil {
            longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(dropPinHere(gestureRecognizer:)))
            longPressRecognizer.minimumPressDuration = 0.5
        }
        mapView.addGestureRecognizer(longPressRecognizer)
    }
    
    func ignoreDropPinGesture() {
        
        guard longPressRecognizer != nil else {
            return
        }
        mapView.removeGestureRecognizer(longPressRecognizer)
    }
    
    @objc func dropPinHere( gestureRecognizer: UIGestureRecognizer ) {
        
        if gestureRecognizer.state == .ended {
            inLongPress = false
            return
        }
        
        guard gestureRecognizer.state == .began && !inLongPress else {
            return
        }
        
        inLongPress = true
        
        let touchPoint = gestureRecognizer.location(in: mapView)
        let newCoordinates = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = newCoordinates
        mapView.addAnnotation(annotation)
    }
}

// MARK: - User remove pins from map

extension MapViewController
{
    @objc func enterPinRemovalMode( _ sender: UIBarButtonItem ) {
        
        ignoreDropPinGesture()
        
        pinMode = .remove
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                            target: self,
                                                            action: #selector(exitPinRemovalMode(_:)))
    }
    
    @objc func exitPinRemovalMode( _ sender: UIBarButtonItem ) {

        prepareToAddPins()
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        if pinMode == .add {
            showDetailFor( annotation: view.annotation )
        }
        else {
            remove( annotation: view.annotation )
        }
    }
    
    func showDetailFor( annotation: MKAnnotation? ) {
        
        guard let annotation = annotation else {
            return
        }

        mapView.deselectAnnotation(annotation, animated: false)
        print( "show pin detail!" )
    }
    
    func remove( annotation: MKAnnotation? ) {
        
        guard let annotation = annotation else {
            return
        }
        
        mapView.removeAnnotation( annotation )
    }
}
