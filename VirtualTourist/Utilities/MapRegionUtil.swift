//
//  MapRegionUtil.swift
//  VirtualTourist
//
//  Created by Glenn Cole on 10/14/19.
//  Copyright © 2019 Glenn Cole. All rights reserved.
//

import MapKit

struct MapRegionUtil
{
    var region: MKCoordinateRegion
}
extension MapRegionUtil
{
    init(center: CLLocationCoordinate2D, span: MKCoordinateSpan) {
        region = MKCoordinateRegion(center: center, span: span)
    }
    init() {
        let dictCenter = UserDefaults.standard.value(forKey: AppDelegate.UserDefaultKeys.mapCenter) as! [String: Double]
        let dictSpan = UserDefaults.standard.value(forKey: AppDelegate.UserDefaultKeys.mapSpan) as! [String: Double]
        
        let latitude = dictCenter[AppDelegate.UserDefaultKeys.mapCenterLat]!
        let longitude = dictCenter[AppDelegate.UserDefaultKeys.mapCenterLng]!
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let latitudeDelta = dictSpan["latitudeDelta"]!
        let longitudeDelta = dictSpan["longitudeDelta"]!
        let span = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
        
        region = MKCoordinateRegion(center: center, span: span)
    }
    func saveAsDefault() {
        let dictCenter = [AppDelegate.UserDefaultKeys.mapCenterLat: region.center.latitude,
                          AppDelegate.UserDefaultKeys.mapCenterLng: region.center.longitude
        ]
        
        let dictSpan = ["latitudeDelta": region.span.latitudeDelta,
                        "longitudeDelta": region.span.longitudeDelta
        ]
        
        UserDefaults.standard.set(dictCenter, forKey: AppDelegate.UserDefaultKeys.mapCenter)
        UserDefaults.standard.set(dictSpan, forKey: AppDelegate.UserDefaultKeys.mapSpan)
    }
}
