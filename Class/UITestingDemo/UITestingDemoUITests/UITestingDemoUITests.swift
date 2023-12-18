//
//  UITestingDemoUITests.swift
//  UITestingDemoUITests
//
//  Created by 이민영 on 2023/12/18.
//

import XCTest

final class UITestingDemoUITests: XCTestCase {
    // 전역객체 생성
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // 이전 메서드에서 생성된 리소스, 인스턴스를 해제하는 코드 부분
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    

    func testWelcomeText() throws {
        // test code 작성
        // UI tests must launch the application that they test.
        
        // text안에 쓴 label이 id처럼 쓰일 수 있음
        //let welcome = app.staticTexts["Welcome!"] // welcome 텍스트 부분 가지고 오는 것
        // 현재 앱에 존재하는 유일한 텍스트 뷰 이기 때문에 이렇게 사용 가능
        let welcome = app.staticTexts.element
        
        
        XCTAssert(welcome.exists) // welcome element가 실제로 나타나고 있는지 true/false로 나타냄
        XCTAssertEqual(welcome.label, "Welcome!")
    }
    
    func testLoginButton() throws {
        
//        let login = app.buttons["Login"]
        let login = app.buttons.element
        
        XCTAssert(login.exists)
        XCTAssertEqual(login.label, "Login!")
    }

    func testLaunchPerformance() throws {
        // 성능 테스트 하는 곳
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
