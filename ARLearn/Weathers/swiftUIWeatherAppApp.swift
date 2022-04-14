//
//  swiftUIWeatherAppApp.swift
//  ARLearn
//
//  Created by MERT on 28.11.2021.
//

import Foundation
import SwiftUI

 struct swiftUIWeatherAppApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherSwiftUi()
                .environmentObject(ARViewController.shared)
        }
    }
}
