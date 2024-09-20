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
        Map(mapVM: mapVM)
            .onAppear(perform: {
                mapVM.checkLocationPermission()
            })
    }
}

struct Map: UIViewRepresentable {
    @ObservedObject var mapVM: MapViewModel
    
    init(mapVM: MapViewModel) {
        self.mapVM = mapVM
    }
    
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
        let map = uiView.mapView
        addPathOverlay(map)
    }
    
    // 경로선 그리는 함수
    func addPathOverlay(_ map: NMFMapView) {
        let pathOverlay = NMFPath()
        pathOverlay.color = .blue
        pathOverlay.path = NMGLineString(points: mapVM.userPath)
        pathOverlay.mapView = map
    }
}

#Preview {
    MapPage()
}
