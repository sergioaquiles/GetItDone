//
//  WeatherDetailView.swift
//  GetItDone
//
//  Created by Sergio Cardoso on 24/11/21.
//

import SwiftUI


struct WeatherDetailView: View {
    
    @EnvironmentObject var nm: NetworkingManager
    @EnvironmentObject var lm: LocationManager
    
    var body: some View {
        
        VStack {
            HStack {
                Image(systemName: "location.circle.fill")
                Text(lm.location)
            }
            .padding(.top, 15)
            
            VStack {
                Text("\(nm.weather.temperatureString)ºC")
                    .font(.system(size: 85, weight: .light, design: .rounded))
                    .minimumScaleFactor(0.5)
                Text(nm.weather.description)
                    .padding(.bottom, 15)
                if #available(iOS 15.0, *) {
                    VStack {
                        Image(systemName: nm.weather.conditionName)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(Color.white, .yellow)
                            .font(.system(size: 75))
                    }
                }
            }
        }
        .padding(10)
        .frame(width: 310, height: 310)
        .background(.ultraThinMaterial)
        .clipShape(Circle())
        .background(
            Circle().stroke(lineWidth: 20).opacity(0.7)
                .frame(width: 330, height: 330)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
        )
    }
}


struct WeatherDetailView_Previews: PreviewProvider {
    static var previews: some View {
        //HomeView()
        WeatherDetailView()
            .background(Image("backgroundDark"))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
            .environmentObject(NetworkingManager())
            .environmentObject(LocationManager())
    }
}



