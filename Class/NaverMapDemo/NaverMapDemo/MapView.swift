//
//  MapView.swift
//  NaverMapDemo
//
//  Created by 이민영 on 2024/01/16.
//

import SwiftUI
import NMapsMap

struct MapView: View {
    @State var coord: (Double, Double) = (126.9784147, 37.5666805)
    @State var name: String = ""
    
    var body: some View {
        ZStack {
            VStack {
                TextField("장소 검색: ", text: $name)
                    .foregroundColor(.black)
                    .background(Color.white)
                Button(action: {coord = (129.05562775, 35.1379222)}) {
                    Text("Move to Busan")
                }
                Button(action: {coord = (127.269311, 37.413294)}) {
                    Text("Move to Seoul somewhere")
                }
                Spacer()
            }
            .zIndex(1)
            
            UIMapView(coord: coord)
                .ignoresSafeArea(.all)
            
        }
    }
    
}

struct UIMapView: UIViewRepresentable {
    var coord: (Double, Double)
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        let view = NMFNaverMapView()
        view.showZoomControls = false
        view.mapView.positionMode = .direction
        view.mapView.zoomLevel = 17
        
        return view
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        let coord = NMGLatLng(lat: coord.1, lng: coord.0)
        let cameraUpdate = NMFCameraUpdate(scrollTo: coord)
        cameraUpdate.animation = .fly
        cameraUpdate.animationDuration = 1
        uiView.mapView.moveCamera(cameraUpdate)
    }
    
}

#Preview {
    MapView()
}
