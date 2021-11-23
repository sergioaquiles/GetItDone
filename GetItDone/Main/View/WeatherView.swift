//
//  WeatherView.swift
//  GetItDone
//
//  Created by Sergio Cardoso on 19/11/21.
//

import SwiftUI

struct WeatherView: View {
    
    @ObservedObject var nm = NetworkingManager()
    
    var body: some View {
        
        Button {
            
        } label: {
            HStack(spacing: 10) {
                if #available(iOS 15.0, *) {
                    Image(systemName: nm.weather.conditionName)
                        .font(.body)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.theme.accent, .yellow)
                }
                Text("\(nm.weather.temperatureString)º em \(nm.weather.cityName)")
                    .font(.body)
            }
            .padding(5)
            .cornerRadius(15)
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
