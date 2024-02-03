////
////  CounterFeature.swift
////  TCA_tutorial
////
////  Created by 이민영 on 2024/01/12.
////
//
//import ComposableArchitecture
//
//@Reducer
//struct CounterFeature {
//    struct State {
//        var count = 0
//    }
//    
//    enum Action {
//        case decrementButtonTapped
//        case incrementButtonTapped
//    }
//    
//    // reduce 정의
//    var body: some ReducerOf<Self> {
//        Reduce { state, action in
//            switch action {
//            case .decrementButtonTapped:
//                state.count -= 1
//                return .none
//                
//            case .incrementButtonTapped:
//                state.count += 1
//                return .none
//                
//            }
//        }
//    }
//}
//
