//
//  tempPlace.swift
//  NaverMapDemo
//
//  Created by 이민영 on 2024/01/22.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let places = try? JSONDecoder().decode(Places.self, from: jsonData)

import Foundation

// MARK: - Places
struct tempPlaces: Codable {
    let result: Result
}

// MARK: - Result
struct Result: Codable {
    let type: String
    let place: Place
}

struct Place: Codable {
    let list: [Lists]
}

// MARK: - List
struct Lists: Codable {
    let index, rank, id, name: String
    let tel: String // 전화번호
    let category: [String] // 병원,의원 안과
    let businessStatus: BusinessStatus
    let address, roadAddress, abbrAddress: String // 주소 - roadAddress 기준으로
    let shortAddress: [String]
    let reviewCount, placeReviewCount: Int
    let thumUrls: [String] // 썸네일 이미지
    let x, y: String
    let description: String
    let distance: String
}

// MARK: - BusinessStatus
struct BusinessStatus: Codable {
    let status: Status // 현재 "진료중", "진료 종료" 상태
    let businessHours, breakTime, lastOrder: String
}

// MARK: - Status
struct Status: Codable {
    let description: String
    let detailInfo: String // "17:30에 종료"
}



