//
//  Restaurant.swift
//  FirebaseDemo
//
//  Created by 박준영 on 1/5/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Restaurant : Codable, Hashable {
    var name: String
    var address: String
    var dateAdded: Timestamp
    
    // dateAdded 입력 생략시 기본 데이터로 초기화
    init(name: String, address: String,
         dateAdded: Timestamp = Timestamp(date: Date())) {
        
        self.name = name
        self.address = address
        self.dateAdded = dateAdded
    }
}

class RestaurantStore: ObservableObject {
    static let shared = RestaurantStore()
    
    private init() {}
    
    @Published var restaurants = [Restaurant]()
    
    let db = Firestore.firestore()
    let collectionName = "Restaurants"
    var listener: ListenerRegistration?
    
    // 컬렉션 전체 문서 데이터 불러오기
    func fetchAllRestaurant() {
        db.collection(collectionName).getDocuments() { (snapshot, error) in
            guard error == nil else { return }
            
            // 기존 목록 비우기
            self.restaurants.removeAll()
            
            // 새로운 목록으로 채우기
            for document in snapshot!.documents {
                if let rest = try? document.data(as: Restaurant.self) {
                    self.restaurants.append(rest)
                    print("data", rest)
                }
            }
        }
        
    }
    
    // 컬렉션에 문서 데이터 추가하기 1
    func addRestaurant(docName: String, docData: [String : Any]) {
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
    func addRestaurant(restaurant: Restaurant) {
        try? db.collection(collectionName).document(restaurant.name).setData(from: restaurant)
    }
    
    // 문서 데이터 부분 변경(갱신)
    func updateRestaurant(restaurantName: String, restaurantAddress: String) {
        let docRef = db.collection(collectionName).document(restaurantName)
        docRef.updateData(["address": restaurantAddress]) { error in
            if let error = error {
                print("Error writing document:", error)
            } else {
                print("Success merged:", restaurantName)
            }
        }
    }
    
    // 문서 데이터 삭제
    func deleteRestaurant(restaurantName: String) {
        let docRef = db.collection(collectionName).document(restaurantName)
        docRef.delete() { error in
            if let error = error {
                print("Error deleting document:", error)
            } else {
                print("Success deleted:", restaurantName)
            }
        }
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
                    if let storeRest = try? diff.document.data(as: Restaurant.self) {
                        self.restaurants.append(storeRest)
                        print("add data", storeRest)
                    }
                }
                
                if (diff.type == .modified) {
                    print("Modified city: \(diff.document.data())")
                }
                
                if (diff.type == .removed) {
                    if let storeRest = try? diff.document.data(as: Restaurant.self) {
                        for (index, item) in self.restaurants.enumerated() where storeRest.name == item.name {
                            self.restaurants.remove(at: index)
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
