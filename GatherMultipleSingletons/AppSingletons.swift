//
//  AppSingletons.swift
//  LocationSampleApp
//
//  Created by Javier Calatrava on 1/12/24.
//

import Foundation

@MainActor
struct AppSingletons {
    var locationManager: LocationManager
    var longTaskManager: LongTaskManager
    
    init(locationManager: LocationManager = LocationManager.shared,
         longTaskManager: LongTaskManager = LongTaskManager.shared) {
        self.locationManager = locationManager
        self.longTaskManager = longTaskManager
    }
}

@MainActor var appSingletons = AppSingletons()
