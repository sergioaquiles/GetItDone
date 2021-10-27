//
//  ShowMap.swift
//  GetItDone
//
//  Created by Sergio Cardoso on 09/10/21.
//

import SwiftUI
import MapKit


struct ShowMap: View {
    
    @StateObject private var mapVM = MapViewModel()
    
    
    var body: some View {
        
        ZStack(alignment: .top) {
            
            Map(coordinateRegion: $mapVM.region, interactionModes: .all, showsUserLocation: true, annotationItems: mapVM.places) { place in
                MapAnnotation(coordinate: place.place.location!.coordinate) {
                    
                }
            }
            .ignoresSafeArea()
            
            VStack {
                SearchField(searchField: $mapVM.searchText)
                    .padding()
                if mapVM.searchText != "" && !mapVM.places.isEmpty {
                    ScrollView {
                        VStack {
                            ForEach(mapVM.places) { place in
                                Text(place.place.name ?? "No name")
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading)
                            }
                        }
                    }
                }
            }
        }
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

struct ShowMap_Previews: PreviewProvider {
    static var previews: some View {
        ShowMap()
            .preferredColorScheme(.dark)
        
    }
}
