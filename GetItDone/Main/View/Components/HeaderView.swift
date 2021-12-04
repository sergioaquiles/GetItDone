//
//  HeaderView.swift
//  GetItDone
//
//  Created by Sergio Cardoso on 14/09/21.
//

import SwiftUI

struct HeaderView: View {
    
    @EnvironmentObject var nm: NetworkingManager
    @EnvironmentObject var lm: LocationManager
    @State private var showInfoView = false
    @State private var showAlert = false
    @Binding var showWeather: Bool
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            HStack(spacing: 15) {
                Text("Get It Done")
                    .font(.system(.largeTitle, design: .default))
                    .fontWeight(.medium)
                
                Spacer()
                
                EditButton()
                    .font(.system(size: 16, weight: .semibold))
                    .frame(width: 70, height: 24)
                    .background(
                        Capsule().stroke(LinearGradient(colors: [Color.theme.ligthYellow, Color.theme.darkYellow], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 3)
                    )
                Button {
                    withAnimation {
                        showInfoView.toggle()
                    }
                } label: {
                    Image(systemName: "info.circle")
                        .font(.system(size: 25))
                }
                .sheet(isPresented: $showInfoView) {
                    InfoView()
                }
            }
            .foregroundColor(Color.theme.accent)
           
            Button {
                
                if lm.locationEnabled {
                    showWeather.toggle()
                } else {
                    showAlert.toggle()
                }
                
            } label: {
                HStack(spacing: 10) {
                    if #available(iOS 15.0, *) {
                        Image(systemName: lm.locationEnabled ? nm.weather.conditionName : "questionmark.circle.fill")
                            .font(.body)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(Color.theme.accent, .yellow)
                    }
                    Text(lm.locationEnabled ? "\(nm.weather.temperatureString)ºC" : "0ºC")
                        .font(.body)
                }
                .padding(8)
                .background(
                    Color.theme.secondaryText.opacity(0.5)
                )
                .clipShape(Capsule())
            }
            .alert("Location Denied", isPresented: $showAlert) {
                Button("Ok") {}
                Button("Settings") {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }
            } message: {
                Text("Impossible to check the weather on your location, please go to settings and enable it")
            }
        }
        .onAppear{
            nm.getWeather()
        }
        .padding()
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(showWeather: .constant(false))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
            .environmentObject(NetworkingManager())
            .environmentObject(LocationManager())
    }
}
