//
//  NetworkManager.swift
//  GetItDone
//
//  Created by Sergio Cardoso on 20/11/21.


import Foundation
import SwiftUI
import CoreLocation

class NetworkingManager: ObservableObject {
    
    @Published var weather = WeatherModel(conditionId: 200, cityName: "", temperature: 0.0)
    
    
    init() {
        getWeather()
    }
    
    func getWeather() {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(LocationManager.shared.latitude)&lon=\(LocationManager.shared.longitude)&appid=a267f2b372edfaa1d5f35d0d1a0c0a68&units=metric") else { return }
        downloadData(from: url) { returnedData in
            if let data = returnedData {
                guard let newWeather = try? JSONDecoder().decode(WeatherData.self, from: data) else { return }
                DispatchQueue.main.async {  
                    self.weather.cityName = newWeather.name
                    self.weather.temperature = newWeather.main.temp
                    self.weather.conditionId = newWeather.weather[0].id
                    print(newWeather.name)
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


