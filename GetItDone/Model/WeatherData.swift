//
//  WeatherData.swift
//  GetItDone
//
//  Created by Sergio Cardoso on 21/11/21.
//

import Foundation


// MARK: - WeatherData
struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let visibility: Int
    let wind: Wind
    let dt: Int
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
}


