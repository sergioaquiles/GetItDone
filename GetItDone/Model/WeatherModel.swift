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
    
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "cloud.fog.fill"
        case 800:
            return "sun.max.fill"
        case 801...804:
            return "cloud.fill"
        default:
            return "cloud.fill"
        }
    }
    
}
