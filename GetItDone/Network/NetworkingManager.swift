//
//  NetworkManager.swift
//  GetItDone
//
//  Created by Sergio Cardoso on 20/11/21.


import Foundation
import SwiftUI
import CoreLocation

class NetworkingManager: ObservableObject {
    
    @Published var weather = WeatherModel(conditionId: 200, cityName: "", temperature: 0.0, tempMin: 0.0, tempMax: 0.0, description: "")
    let apiKey = "YOUR API KEY GOES HERE"
    
    func getWeather() {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(LocationManager.shared.latitude)&lon=\(LocationManager.shared.longitude)&appid=\(apiKey)&units=metric") else { return }
        downloadData(from: url) { returnedData in
            if let data = returnedData {
                guard let newWeather = try? JSONDecoder().decode(WeatherData.self, from: data) else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.weather.cityName = newWeather.name
                    self?.weather.temperature = newWeather.main.temp
                    self?.weather.conditionId = newWeather.weather[0].id
                    self?.weather.tempMin = newWeather.main.tempMin
                    self?.weather.tempMax = newWeather.main.tempMax
                    self?.weather.description = newWeather.weather[0].description
                }
            }
        }
    }
    private func downloadData(from url: URL, completionHandler: @escaping (_ data: Data?) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300
            else {
                print("Error downloading data...")
                completionHandler(nil)
                return
            }
            completionHandler(data)
        }
        .resume()
    }
}


