//
//  ContentView.swift
//  SwiftAPIDemo
//
//  Created by 이민영 on 2023/11/30.
//

import SwiftUI



struct ContentView: View {
    
    @StateObject var network = NewsAPI.shared
    
    var body: some View {
        NavigationStack{
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
        }
        .padding()
        .onAppear(){
            network.fetchData()
        }
    }
        
    
    
    
}

//#Preview {
//    ContentView()
//}
