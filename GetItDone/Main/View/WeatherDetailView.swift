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
    private let width = UIScreen.main.bounds.width
    private let height = UIScreen.main.bounds.height
    
    
    var body: some View {
        ZStack{
            
            Color.theme.darkYellow.opacity(0.6)
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                HStack {
                    Image(systemName: "location.circle.fill")
                    Text(lm.location)
                }
                .padding(.top, 15)
                
                Spacer()
                VStack {
                    HStack(spacing: 20) {
                        if #available(iOS 15.0, *) {
                            VStack {
                                Image(systemName: nm.weather.conditionName)
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(Color.theme.accent, .yellow)
                                    .font(.system(size: 75))
                            }
                        }
                        Text("\(nm.weather.temperatureString)ºC")
                            .font(.system(size: 85, weight: .light, design: .rounded))
                            .minimumScaleFactor(0.5)
                            
                            
                    }
                    Text(nm.weather.description)
                }
                
                Spacer()
            }
        }
        .frame(width: width - 70, height: 200)
        .cornerRadius(25)
        .background(
            RoundedRectangle(cornerRadius: 25).stroke(lineWidth: 2)
        )
    }
}


struct WeatherDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailView()
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
            .environmentObject(NetworkingManager())
            .environmentObject(LocationManager())
    }
}



