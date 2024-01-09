//
//  City.swift
//  FirebaseDemo
//
//  Created by 이민영 on 2024/01/08.
//

import Foundation
import Firebase

struct City: Codable, Hashable {
    var name: String
    var state: String
    var country: String
    var capital: Bool
    var population: Int
    var regions: [String]
    
    init(name: String, state: String, country: String, capital: Bool, population: Int, regions: [String]) {
        self.name = name
        self.state = state
        self.country = country
        self.capital = capital
        self.population = population
        self.regions = regions
    }
}

class CityStore: ObservableObject {
    static let shared = CityStore()
    
    private init() {
        let db = Firestore.firestore()
        let citiesRef = db.collection("City")
        
        citiesRef.document("SF").setData([
            "name": "San Francisco",
            "state": "CA",
            "country": "USA",
            "capital": false,
            "population": 860000,
            "regions": ["west_coast", "norcal"]
        ])
        citiesRef.document("LA").setData([
            "name": "Los Angeles",
            "state": "CA",
            "country": "USA",
            "capital": false,
            "population": 3900000,
            "regions": ["west_coast", "socal"]
        ])
        citiesRef.document("DC").setData([
            "name": "Washington D.C.",
            "country": "USA",
            "capital": true,
            "population": 680000,
            "regions": ["east_coast"]
        ])
        citiesRef.document("TOK").setData([
            "name": "Tokyo",
            "country": "Japan",
            "capital": true,
            "population": 9000000,
            "regions": ["kanto", "honshu"]
        ])
        citiesRef.document("BJ").setData([
            "name": "Beijing",
            "country": "China",
            "capital": true,
            "population": 21500000,
            "regions": ["jingjinji", "hebei"]
        ])
    }
    
    @Published var cities = [City]()
    
    let db = Firestore.firestore()
    let collectionName = "City"
    var listener: ListenerRegistration?
    
    // 컬렉션 전체 문서 데이터 불러오기
    func fetchAllRestaurant() {
        db.collection(collectionName).getDocuments() { (snapshot, error) in
            guard error == nil else { return }
            
            // 기존 목록 비우기
            self.cities.removeAll()
            
            // 새로운 목록으로 채우기
            for document in snapshot!.documents {
                if let city = try? document.data(as: City.self) {
                    self.cities.append(city)
                    print("data", city)
                }
            }
        }
        
    }
    
    // 컬렉션에 문서 데이터 추가하기 1
    func addCity(docName: String, docData: [String : Any]) {
        let docRef = db.collection(collectionName).document(docName)
        docRef.setData(docData) { error in
            if let error = error {
                print(error)
            } else {
                print("Success:", docName)
            }
        }
    }
    
    // 컬렉션에 문서 데이터 추가하기 2
    func addCity(city: City) {
        try? db.collection(collectionName).document(city.name).setData(from: city)
    }
    
    // 문서 데이터 부분 변경(갱신)
    func updateCity(cityName: String, cityAddress: String) {
        let docRef = db.collection(collectionName).document(cityName)
        docRef.updateData(["address": cityAddress]) { error in
            if let error = error {
                print("Error writing document:", error)
            } else {
                print("Success merged:", cityName)
            }
        }
    }
    
    // 문서 데이터 삭제
    func DeleteCity(cityName: String) {
        let docRef = db.collection(collectionName).document(cityName)
        docRef.delete() { error in
            if let error = error {
                print("Error deleting document:", error)
            } else {
                print("Success deleted:", cityName)
            }
        }
    }
    
    func simpleQueries() {
        // [START simple_queries]
        // Create a reference to the cities collection
        let citiesRef = db.collection("City").whereField("state", isEqualTo: "CA")
        
        // Create a query against the collection.
//        let query = citiesRef.whereField("state", isEqualTo: "CA")
        // [END simple_queries]
        
        let query: Void = citiesRef.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        if let data = try? document.data(as: City.self) {
                            print(data)
                        }
                    }
                }
            }
        }
        
        // [START simple_query_not_equal]
//        let notEqualQuery = citiesRef.whereField("capital", isNotEqualTo: false)
        // [END simple_query_not_equal]
    
    }
    
    
    
    // Cloud Firestore로 실시간 업데이트 가져오기
    // 데이터베이스를 실시간으로 관찰하여 데이터 변경 여부를 확인
    func startListening() {
        listener =
        db.collection(collectionName).addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot, error == nil else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            
            snapshot.documentChanges.forEach { diff in
                if (diff.type == .added) {
                    if let storeRest = try? diff.document.data(as: City.self) {
                        self.cities.append(storeRest)
                        print("add data", storeRest)
                    }
                }
                
                if (diff.type == .modified) {
                    print("Modified city: \(diff.document.data())")
                }
                
                if (diff.type == .removed) {
                    if let storeRest = try? diff.document.data(as: City.self) {
                        for (index, item) in self.cities.enumerated() where storeRest.name == item.name {
                            self.cities.remove(at: index)
                        }
                    }
                }
            }
        }
    }
    
    // 데이터베이스를 실시간으로 관찰하는 것을 중지
    func stopListening() {
        listener?.remove()
        print("stopListening")
    }
    
    
    
}

