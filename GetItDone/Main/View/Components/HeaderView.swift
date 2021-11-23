//
//  HeaderView.swift
//  GetItDone
//
//  Created by Sergio Cardoso on 14/09/21.
//

import SwiftUI

struct HeaderView: View {
    
    @State private var showInfoView = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            
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
           
            WeatherView()
        }
        .padding()
        
        
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HeaderView()
                .previewLayout(.sizeThatFits)
            HeaderView()
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark
                )
        }
        
    }
}
