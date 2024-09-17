//
//  MapPage.swift
//  RunUs
//
//  Created by 가은 on 9/9/24.
//

import NMapsMap
import SwiftUI

struct MapPage: View {
    @StateObject var mapVM: MapViewModel = MapViewModel()
    
    var body: some View {
        Map()
            .onAppear(perform: {
                mapVM.checkLocationPermission()
            })
    }
}

struct Map: UIViewRepresentable {
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        let map = NMFNaverMapView()
        map.showLocationButton = true
        return map
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

#Preview {
    MapPage()
}
