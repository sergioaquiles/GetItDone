//
//  WeatherModel.swift
//  GetItDone
//
//  Created by Sergio Cardoso on 20/11/21.
//

import Foundation



struct WeatherModel {
    var conditionId: Int
    var cityName: String
    var temperature: Double
    var tempMin: Double
    var tempMax: Double
    var description: String
    
    
    var temperatureString: String {
        return String(format: "%.0f", temperature.rounded())
    }
    var minimum: String {
        return String(format: "%.0f", tempMin.rounded())
    }
    var maximum: String {
        return String(format: "%.0f", tempMax.rounded())
    }
    
    private let time = Calendar.current.component(.hour, from: Date())
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloudBolt"
        case 300...321:
            return "cloudRain"
        case 500...531:
            return "cloudRain"
        case 600...622:
            return "cloudSnow"
        case 701...781:
            return "cloudFog"
        case 800:
            if time < 18 {
                return "sunMax"
            } else {
                return "moonmax"
            }
        case 801...804:
            if time < 18 {
                return "cloud"
            } else {
                return "cloudmoon"
            }
        default:
            return "cloud"
        }
    }
}
