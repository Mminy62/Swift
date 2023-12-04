//
//  WeatherAPI.swift
//  SwiftAPIDemo
//
//  Created by 이민영 on 2023/11/30.
//

import Foundation
import SwiftUI

struct Weather: Decodable{
    let coord: Location
    let weather: [WeatherInfo]
    let name: String
}

struct Location: Decodable{
    let lon: Double
    let lat: Double
}

struct WeatherInfo: Decodable, Hashable{
    let id: Int
    let main: String
    let icon: String
}

class WeatherAPI: ObservableObject{
    static let shared = WeatherAPI()
    @Published var weatherImg: String?
    @Published var weatherName: String?
    @Published var city: String?
    var lat: String
    var lon: String
    
    
    @StateObject var locationDataManager = LocationDataManager()
    
    
    init(weatherImg: String? = nil, weatherName: String? = nil, city: String? = nil, lat: String  = "", lon: String = "") {
        self.weatherImg = weatherImg
        self.weatherName = weatherName
        self.lat = lat
        self.lon = lon
    }
    
    func fetchLocation(){
        switch locationDataManager.locationManager.authorizationStatus {
        case .authorizedWhenInUse:  // Location services are available.
            // Insert code here of what should happen when Location services are authorized
            
            if let coordinate = locationDataManager.locationManager.location?.coordinate {
                self.lat = coordinate.latitude.description
                self.lon = coordinate.longitude.description
                print(self.lat, self.lon)
            }
            fetchData()
        case .restricted, .denied:  // Location services currently unavailable.
            // Insert code here of what should happen when Location services are NOT authorized
            print("Current location data was restricted or denied.")
        case .notDetermined:        // Authorization not determined yet.
            print("Finding your location...")
//            ProgressView()
        default:
//            ProgressView()
            print("default")
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
//        let lat = 37.5799386
//        let lon = 126.8120882
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(self.lat)&lon=\(self.lon)&appid=\(apiKey)"
        
        
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                // 정상적으로 값이 오지 않았을 때 처리
                self.weatherImg = ""
                self.weatherName = ""
                self.lat = ""
                self.lon = ""
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            
            //            let str = String(decoding: data, as: UTF8.self)
            //            print(str)
            do {
                let json = try JSONDecoder().decode(Weather.self, from: data)
                DispatchQueue.main.async {
                    let imgString = json.weather[0].icon
                    self.weatherImg = "https://openweathermap.org/img/wn/\(imgString)@2x.png"

                    self.weatherName = json.weather[0].main
                    self.city = json.name
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
        }
        task.resume()
        
    }
    

    
}
