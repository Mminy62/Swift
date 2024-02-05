//
//  TodoViewModel.swift
//  voiceMemo
//

import Foundation

class TodoViewModel: ObservableObject {
    @Published var title: String
    @Published var time: Date // picker로 선택하기 때문에 Date()
    @Published var day: Date
    @Published var isDisplayCalendar: Bool
    
    init(
        title: String = "",
        time: Date = Date(),
        day: Date = Date(),
        isDisplayCalendar: Bool = false
    ) {
        self.title = title
        self.time = time
        self.day = day
        self.isDisplayCalendar = isDisplayCalendar
    }
}


extension TodoViewModel {
    // set 함수 생성
    func setIsDisplayCalendar(_ isDisplay: Bool) {
        isDisplayCalendar = isDisplay
    }
    
}
