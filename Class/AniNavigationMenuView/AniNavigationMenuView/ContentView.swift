//
//  ContentView.swift
//  AniNavigationMenuView
//
//  Created by 이민영 on 2023/12/20.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationMenu()
    }
}

// 중복된 코드 ForEach 를 사용하여 단순화
struct NavigationMenu: View {
    
    @State var selectedIndex = 0
    let menuItems = ["Travel", "Nature", "Architecture"]
    
    @Namespace private var menuItemTransition
    
    var body: some View {
        HStack {
            Spacer()
            
            ForEach(menuItems.indices, id: \.self) { index in
                
                if index == selectedIndex {
                    Text(menuItems[index])
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                        .background(Capsule().foregroundStyle(.purple))
                        .foregroundStyle(.white)
                    // 메뉴항목이 선택될 때 마다 보기 변경에 애니메이션을 적용
                    // ID, 네임스페이스는 동일한 전환의 일부인 뷰를 식별하는데 사용
                        .matchedGeometryEffect(id: "menuItem", in: menuItemTransition)
                } else {
                    Text(menuItems[index])
                        .padding(.horizontal)
                        .padding(.vertical, 4)
                        .background(Capsule().foregroundStyle(Color(uiColor: UIColor.systemGray5)))
                        .foregroundStyle(.black)
                        .onTapGesture {
                            selectedIndex = index
                        }
                }
                
                Spacer()
            }
            
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        // selectedIndex가 바뀔때 easeInOut 효과를 준다는 것
        .animation(.easeInOut, value: selectedIndex)
    }
}

#Preview {
    ContentView()
}
