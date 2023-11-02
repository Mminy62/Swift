//
//  ContentView.swift
//  MusicApp
//
//  Created by 이민영 on 2023/11/02.
//

import SwiftUI


struct ContentView: View {
    
    @StateObject var musicStore: MusicStore = MusicStore(musics: musicData)

    
    var body: some View {
        
    
        NavigationStack{

                VStack{
                   

                    List {
                        ForEach(0..<musicStore.musics.count, id: \.self) { i in
                            NavigationLink(value: i) {
                                MusicList(musicStore: musicStore, i: i)
                                    
                                
                            }.listRowBackground(Color.yellow)
                        }
                        
                        
                    }
                    
                    .navigationDestination(for: Int.self) { i in
                        // 음악 세부사항 View 넣기
                    }
                    .navigationTitle("GuMusic")
                    
                    
                
                }
         
        }
        
    }
    
    
}

struct MusicList: View {
    let musicStore: MusicStore
    let i : Int
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: musicStore.musics[i].image.first?.text ?? ""))
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading, content: {
                Text(musicStore.musics[i].name)
                    .font(.headline)
                    .lineLimit(3) //3줄까지만 제한을 둔다.
                Text(musicStore.musics[i].artist.name)
                
                    
            })
        }
        
    }
}


#Preview {
    ContentView()
}
