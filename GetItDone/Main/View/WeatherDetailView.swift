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
        
        ZStack {
            
            Circle().fill(Color.black.opacity(0.2))
                .frame(width: 310, height: 310)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
            Circle().stroke(lineWidth: 20)
                .foregroundColor(Color.theme.darkYellow.opacity(0.5))
                .frame(width: 330, height: 330)
            
            VStack {
                
                HStack {
                    Image(systemName: "location.circle.fill")
                    Text(lm.location)
                }
                .padding(.top, 15)
                
                VStack(spacing: 5) {
                    
                    Text("\(nm.weather.temperatureString)ºC")
                        .font(.system(size: 65, weight: .light, design: .rounded))
                        .minimumScaleFactor(0.5)
                    Text(nm.weather.description.capitalized)
                        .padding(.bottom, 10)
                        
                    if #available(iOS 15.0, *) {
                        VStack {
                            Image(nm.weather.conditionName)
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(Color.white, .yellow)
                                .font(.system(size: 65))
                        }
                    }
                }
            }
        }
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



