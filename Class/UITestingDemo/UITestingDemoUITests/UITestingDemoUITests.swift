//
//  UITestingDemoUITests.swift
//  UITestingDemoUITests
//
//  Created by 이민영 on 2023/12/18.
//

import XCTest

final class UITestingDemoUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // 이전 메서드에서 생성된 리소스, 인스턴스를 해제하는 코드 부분
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWelcome() throws {
        // test code 작성
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // text안에 쓴 label이 id처럼 쓰일 수 있음
        let welcome = app.staticTexts["Welcome!"] // welcome 텍스트 부분 가지고 오는 것
        
        XCTAssert(welcome.exists) // welcome element가 실제로 나타나고 있는지 true/false로 나타냄
        
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
