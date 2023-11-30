//
//  ContentView.swift
//  SwiftAPIDemo
//
//  Created by 이민영 on 2023/11/30.
//

import SwiftUI



struct ContentView: View {
    
    @StateObject var network = NewsAPI.shared
    @StateObject var weatherNetwork = WeatherAPI.shared
    
    var body: some View {
            
        NavigationStack(){
            List{
                ForEach(network.posts, id: \.self){ result in
                    HStack{
                        AsyncImage(url: URL(string: result.urlToImage ?? "")){ image in
                            image.resizable()
                            
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 120, height: 80)
                        
                        Text(result.title)
                    }
                    .padding(5)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("News")
                    .foregroundColor(.white) }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                HStack {
                Text("\(weatherNetwork.name ?? "")")
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
            weatherNetwork.fetchData()
            network.fetchData()
        }
    }
        
    
    
    
}

#Preview {
    ContentView()
}
