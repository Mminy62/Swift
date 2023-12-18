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
        let login = app.buttons["Login"]
        
        XCTAssert(login.exists)
        XCTAssertEqual(login.label, "Login")
    }
    
    
    func testLoginFormAppearance() throws {
        // 로그인 버튼에 대한 탭 동작 트리거
        app.buttons["loginButton"].tap()
        // app 속성을 통해 네비게이션바 타이틀 "Login" 제목을 가져옴
        let loginNavBarTitle = app.staticTexts["Login"]
        // 0.5초 동안 나타나기를 기다림
        XCTAssert(loginNavBarTitle.waitForExistence(timeout: 0.5)) // 바로 확인하면 모달창이 뜰때 전에 확인할까봐
    }
    
    // 로그인 폼의 모든 요소 출력에 대한 테스트
    func testLoginForm() throws {
        app.buttons["loginButton"].tap()
        
        let navBar = app.navigationBars.element
        XCTAssert(navBar.exists)
        
        let username = app.textFields["Username"]
        XCTAssert(username.exists)
        
        let password = app.secureTextFields["Password"]
        XCTAssert(password.exists)
        
        let login = app.buttons["loginNow"]
        XCTAssert(login.exists)
        
        let dismiss = app.buttons["Dismiss"]
        XCTAssert(dismiss.exists)
    }
    
    // 닫기 버튼 테스트
    // 특정 시간이 경과한 후에는 닫기(해제) 버튼이 더 이상 존재하지 않음을 확인
    func testLoginDismiss() throws {
        app.buttons["loginButton"].tap()
        
        let dismiss = app.buttons["Dismiss"]
        dismiss.tap()
        
        XCTAssertFalse(dismiss.waitForExistence(timeout: 0.5))
    }
    
    
    // 사용자 이름 테스트
    // 프로그래밍 방식으로 텍스트 필드에 텍스트를 입력
    func testUsername() throws {
        app.buttons["loginButton"].tap()
        
        let username = app.textFields["Username"]
        username.tap()
        username.typeText("test")
        
        XCTAssertNotEqual(username.value as! String, "")
    }
    
    // 비밀번호 입력 테스트
    // 텍스트 입력을 제공하는 다른 방법 - 키보드 탭 동작을 시뮬레이션
    func testPassword() throws {
        app.buttons["loginButton"].tap()
        
        app.secureTextFields.element.tap()
        app.keys["p"].tap()
        app.keys["a"].tap()
        app.keys["s"].tap()
        app.keys["s"].tap()
        app.keyboards.buttons["Return"].tap()
        
        XCTAssertNotEqual(app.secureTextFields.element.value as! String, "")
    }
    
    // 로그인 실패 테스트
    func testFailedLoginAlert() throws {
        app.buttons["loginButton"].tap()
        app.buttons["loginNow"].tap()
        
        app.alerts.element.buttons["OK"].tap()
        XCTAssertFalse(app.alerts.element.waitForExistence(timeout: 0.5))
    }
    
    // 로그인 프로세스를 테스트
    func testLogin() throws {
        app.buttons["loginButton"].tap()
        
        let username = app.textFields["Username"]
        username.tap()
        username.typeText("test")
        
        let password = app.secureTextFields["Password"]
        password.tap()
        password.typeText("pass")
        app.keyboards.buttons["Return"].tap()
        
        let login = app.buttons["loginNow"]
        login.tap()
        
        XCTAssertFalse(login.waitForExistence(timeout: 0.5))
    }
    
    func login() throws {
        app.buttons["loginButton"].tap()
        
        let username = app.textFields["Username"]
        username.tap()
        username.typeText("test")
        
        let password = app.secureTextFields["Password"]
        password.tap()
        password.typeText("pass")
        app.keyboards.buttons["Return"].tap()
        
        app.buttons["loginNow"].tap()
    }
    
    
    // 환영 메세지 및 로그인 버튼 라벨 테스트
    // "Welcome test!" 표시되면 테스트가 성공
    func testWelcomeAfterLogin() throws {
        XCTAssert(app.staticTexts["Welcome!"].exists)
        try login()
        XCTAssert(app.staticTexts["Welcome test!"].exists)
        XCTAssertFalse(app.staticTexts["Welcome!"].exists)
    }
    
    // 로그인 버튼의 라벨을 확인하기 위한 테스트
    func testLoginLogouLabel() throws {
        XCTAssertEqual(app.buttons["loginButton"].label, "Login")
        try login()
        XCTAssertEqual(app.buttons["loginButton"].label, "Logout")
    }
    
    // 로그아웃 테스트
    // 로그아웃 후 ContentView(첫 화면)의 사용자 인터페이스가 제대로 업데이트 되는지 확인
    func testLogout() throws {
        try login()
        
        XCTAssert(app.staticTexts["Welcome test!"].exists)
        XCTAssertEqual(app.buttons["loginButton"].label, "Logout")
        
        app.buttons["loginButton"].tap()
        
        XCTAssert(app.staticTexts["Welcome!"].exists)
        XCTAssertEqual(app.buttons["loginButton"].label, "Login")
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
