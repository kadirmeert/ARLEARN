//
//  WeatherData.swift
//  ARLearn
//
//  Created by MERT on 24.11.2021.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}
struct Weather: Codable {
    let id: Int
}
struct Main: Codable {
    let temp: Double
}
