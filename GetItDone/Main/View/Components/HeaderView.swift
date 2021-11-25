//
//  HeaderView.swift
//  GetItDone
//
//  Created by Sergio Cardoso on 14/09/21.
//

import SwiftUI

struct HeaderView: View {
    
    @EnvironmentObject var nm: NetworkingManager
    @State private var showInfoView = false
    
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
                // weatherDetailView
            } label: {
                HStack(spacing: 10) {
                    if #available(iOS 15.0, *) {
                        Image(systemName: nm.weather.conditionName)
                            .font(.body)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(Color.theme.accent, .yellow)
                    }
                    Text("\(nm.weather.temperatureString)º")
                        .font(.body)
                }
                .padding(8)
                .background(
                    Color.theme.secondaryText.opacity(0.5)
                )
                .clipShape(Capsule())
            }
        }
        .padding()
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HeaderView()
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
