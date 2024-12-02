//
//  ContentView.swift
//  GatherMultipleSingletons
//
//  Created by Javier Calatrava on 2/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var locationManager = appSingletons.locationManager
    @StateObject private var longTaskManager = appSingletons.longTaskManager
    
    var body: some View {
        VStack(spacing: 20) {
            Text("LongTask is \(longTaskManager.isTaskDone ? "done" : "running...")")
            if let location = locationManager.currentLocation {
                Text("Latitude: \(location.latitude)")
                Text("Longitude: \(location.longitude)")
            } else {
                Text("Location not available")
            }
            
            if let address = locationManager.currentAddress {
                Text("Name: \(address.name ?? "Unknown")")
                Text("Town: \(address.locality ?? "Unknown")")
                Text("Country: \(address.country ?? "Unknown")")
            } else {
                Text("Address not available")
            }
            
            Button(action: {
                locationManager.requestLocation()
            }) {
                Text("Request Location")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .onAppear {
            locationManager.checkAuthorization()
            
            
            Task {
              await longTaskManager.doLongTask()
            }
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
