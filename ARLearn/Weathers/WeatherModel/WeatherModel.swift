//
//  WeatherModel.swift
//  ARLearn
//
//  Created by MERT on 24.11.2021.
//

import Foundation

struct WeatherModel {
    
    let cityName: String
    let temperature: Double
    let conditionID: Int
    
    var conditionName: String {
        
        switch conditionID {
        case 200...232:
            return "thunder"
        case 300...321:
            return "rainy"
        case 500...531:
            return "rainy"
        case 600...622:
            return "snow"
        case 700...781:
            return "fog"
        case 800:
            return "thunder"
        default:
            return "normal"
        }
        
    }
}
