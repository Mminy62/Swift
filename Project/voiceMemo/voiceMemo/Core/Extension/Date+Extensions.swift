//
//  Date+Extensions.swift
//  voiceMemo
//

import Foundation

extension Date {
    var formattedTime: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "a hh:mm" // a - 오전, 오후
        return formatter.string(from: self) // self - Date
    }
    
    // 오늘이면 오늘로 표현, 이전 이후면 날짜로 표시
    var formattedDay: String {
        let now = Date()
        let calendar = Calendar.current
        
        let nowStartOfDay = calendar.startOfDay(for: now)
        let dateStartOfDay = calendar.startOfDay(for: self) // 일정 시작하는 날짜
        
        let numOfDaysDifference = calendar.dateComponents([.day], from: nowStartOfDay, to: dateStartOfDay).day! // day기준으로 얼마나 차이나는지 체크, year, month, hour.. 다 가능
        
        if numOfDaysDifference == 0 {
            return "오늘"
            
        } else {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ko_KR")
            formatter.dateFormat = "M월 d일 E요일"
            return formatter.string(from: self)
        }
        
        
    }
  
}
