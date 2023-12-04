//
//  ContentView.swift
//  WeatherAPIDemo
//
//  Created by 이민영 on 2023/11/30.
//

import SwiftUI


//https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
struct ContentView: View {
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
 
        }
        .padding()
        .onAppear(){
            fetchData()
        }
        
    }
    
    // api key
    private var apiKey: String?{
        get {
            let keyfilename = "ApiKeys"
            let api_key = "WEATHER_API_KEY"
            // 생성한 .plist 파일 경로 불러오기
            // 파일 이름, 형식 넣어서 main.path 사용하기
            guard let filePath = Bundle.main.path(forResource: keyfilename, ofType: "plist") else {
                fatalError("Could not find \(keyfilename).plist")
            }
            
            // .plist 파일 내용을 딕셔너리로 받아오기
            let plist = NSDictionary(contentsOfFile: filePath)
            
            // 딕셔너리에서 키 찾기
            guard let value = plist?.object(forKey: api_key) as? String else {
                fatalError("Could not find key \(api_key)")
            }
            
            return value
        }
    }
    
    func fetchData(){
        guard let apiKey = apiKey else { return }
        print(apiKey)
        let lat = "37.6185"
        let lon = "127.0787"
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)"
        
        
        guard let url = URL(string: urlString) else { return }

                let session = URLSession(configuration: .default)

                let task = session.dataTask(with: url) { data, response, error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }

                    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        // 정상적으로 값이 오지 않았을 때 처리
                        return
                    }

                    guard let data = data else {
                        print("No data received")
                        return
                    }
                    
      
                    let str = String(decoding: data, as: UTF8.self)
                    print(str)
//                    do {
//                        let json = try JSONDecoder().decode(Results.self, from: data)
//                        DispatchQueue.main.async {
//                            self.posts = json.articles
//                        }
//                    } catch let error {
//                        print(error.localizedDescription)
//                    }

                }
                task.resume()
        
    }
    
}



//#Preview {
//    ContentView()
//}
