//
//  MapView.swift
//  GetItDone
//
//  Created by Sergio Cardoso on 29/10/21.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @StateObject var mapVM = MapViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            
            Map(coordinateRegion: $mapVM.region, interactionModes: .all, showsUserLocation: true, annotationItems: mapVM.places) { place in
                
                MapAnnotation(coordinate: place.place.location!.coordinate) {
                    Rectangle().stroke(Color.theme.darkYellow)
                        .frame(width: 20, height: 20)
                }
            }
            .ignoresSafeArea()
            
            VStack {
                SearchField(searchField: $mapVM.searchText)
                    .disableAutocorrection(true)
                    .padding(.horizontal)
                    .padding(.top, 10)
                if mapVM.searchText != "" && !mapVM.places.isEmpty {
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(mapVM.places) { place in
                                Text(place.place.name ?? "No name")
                                    .foregroundColor(Color.theme.darkYellow)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading)
                                    .padding(.top, 10)
                                    .onTapGesture {
                                        mapVM.selectPlace(place: place)
                                    }
                                Divider()
                            }
                        }
                    }
                    .background(Color.theme.background).opacity(0.8)
                    .cornerRadius(15)
                    .padding(.horizontal, 15)
                }
            }
        }
        .environmentObject(mapVM)
        .onChange(of: mapVM.searchText) { Value in
            let delay = 0.3
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                if Value == mapVM.searchText {
                    self.mapVM.searchLocation()
                }
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
