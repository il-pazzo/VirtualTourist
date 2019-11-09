//
//  AppDelegate.swift
//  VirtualTourist
//
//  Created by Glenn Cole on 10/14/19.
//  Copyright © 2019 Glenn Cole. All rights reserved.
//

import UIKit
import MapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        maybeSetUserDefaults()
        return true
    }
    
    func maybeSetUserDefaults() {
        
//        UserDefaults.standard.set(UserDefaultValues.romeCoordinates, forKey: UserDefaultKeys.mapCenter)
//        UserDefaults.standard.set(UserDefaultValues.mapSpan, forKey: UserDefaultKeys.mapSpan)
        if !UserDefaults.standard.bool(forKey: UserDefaultKeys.wasRunPreviously) {
            
            print( "first run; setting defaults" )
            let mapRegionUtil = MapRegionUtil(center: UserDefaultValues.defaultCoordinates,
                                              span: UserDefaultValues.mapSpan)
            mapRegionUtil.saveAsDefault()
            UserDefaults.standard.set(true, forKey: UserDefaultKeys.wasRunPreviously)
            UserDefaults.standard.set(UserDefaultValues.defaultLat, forKey: UserDefaultKeys.mapCenterLat)
            UserDefaults.standard.set(UserDefaultValues.defaultLng, forKey: UserDefaultKeys.mapCenterLng)
            UserDefaults.standard.set(UserDefaultValues.coordinateSpanDelta, forKey:  UserDefaultKeys.coordinateSpanDelta)
        }
    }
}

extension AppDelegate
{
    enum NavigationConstants {
        
        static let appName = "Virtual Tourist"
    }
    
    enum UserDefaultKeys {
        
        static let wasRunPreviously = "wasRunPreviously"
        static let mapCenterLat = "mapCenterLat"
        static let mapCenterLng = "mapCenterLng"
        static let coordinateSpanDelta = "coordinateSpanDelta"
        static let mapCenter = "mapCenter"
        static let mapSpan = "mapSpan"
    }
    
    enum UserDefaultValues {
        
        // Rome
        static let defaultLat = 41.883333
        static let defaultLng = 12.5
        static let defaultCoordinates = CLLocationCoordinate2D(latitude: defaultLat, longitude: defaultLng)

        static let coordinateSpanDelta = 0.5
        static let mapSpan = MKCoordinateSpan(latitudeDelta: 10.0, longitudeDelta: 10.0)
    }
}

