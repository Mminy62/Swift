//
//  ContentView.swift
//  SwiftAPIDemo
//
//  Created by 이민영 on 2023/11/30.
//

import SwiftUI
import _CoreLocationUI_SwiftUI

struct ContentView: View {
    
    @StateObject var network = NewsAPI.shared
    @StateObject var weatherNetwork = WeatherAPI.shared
    @StateObject var locationNetwork = LocationDataManager.shared
    @StateObject var locationDataManager = LocationDataManager()
    

    
    var body: some View {
        
        NavigationStack(){
            ScrollView{
                LazyVGrid(columns: [ GridItem(.flexible()),  GridItem(.flexible())], content: {
                    ForEach(network.posts, id: \.self) {result in
                        NavigationLink(destination: NewsWebView(urlToLoad: result.url)){
                            VStack{
                                AsyncImage(url: URL(string: result.urlToImage ?? "")){ image in
                                    image.resizable()
                                    
                                } placeholder: {
                                    ProgressView()
                                }
                                
                                .frame(maxWidth:140, maxHeight: 90, alignment: .topTrailing)
                                
                                
                                Text(result.title)
                                    .frame(width: 100, height: 90)
                                    .minimumScaleFactor(0.5)
                                
                            }
                        }
                        .padding(5)
                    }
                })
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Apple News")
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                HStack {
                Text("\(weatherNetwork.city ?? "")")
                AsyncImage(url: URL(string: weatherNetwork.weatherImg ?? "")){ image in
                    image.resizable()
                    
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
            }
                                
            )
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(Color.orange, for: .navigationBar)
            
            
        }
        .padding()
        .onAppear(){
            
            weatherNetwork.fetchLocation()
            network.fetchData()
            /*fetchLocation*/()
            
        }
    }
    
//    func fetchLocation(){
//        switch locationDataManager.locationManager.authorizationStatus {
//        case .authorizedWhenInUse:  // Location services are available.
//            // Insert code here of what should happen when Location services are authorized
//            let lat = locationDataManager.locationManager.location?.coordinate.latitude
//            let lon = locationDataManager.locationManager.location?.coordinate.longitude
//            print(lat, lon)
//            
//            
//        case .restricted, .denied:  // Location services currently unavailable.
//            // Insert code here of what should happen when Location services are NOT authorized
//            print("Current location data was restricted or denied.")
//        case .notDetermined:        // Authorization not determined yet.
//            print("Finding your location...")
////            ProgressView()
//        default:
////            ProgressView()
//            print("default")
//        }
//      
//    }
    
    
}

#Preview {
    ContentView()
}
