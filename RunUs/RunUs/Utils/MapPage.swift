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
        
        // 사용자 위치로 지도 화면 이동
        let cameraUpdate = NMFCameraUpdate(scrollTo: map.mapView.cameraPosition.target)
        map.mapView.moveCamera(cameraUpdate)
        
        map.showLocationButton = true
        map.mapView.positionMode = .direction
        
        return map
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

#Preview {
    MapPage()
}
