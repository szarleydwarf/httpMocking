//
//  HTTPMockingUITests.swift
//  HTTPMockingUITests
//
//  Created by The App Experts on 26/03/2023.
//

import XCTest
@testable import HTTPMocking

final class HTTPMockingUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        self.app = XCUIApplication()
        self.continueAfterFailure = true
        self.app.launchEnvironment = ["ENV": "TEST"]
        self.app.launch()
    }

    func test_display_user_info() {
        let usernameTF =  self.app.textFields["username"]
        let passwordTF =  self.app.textFields["password"]
        print("user -> ", usernameTF)
        usernameTF.tap()
        usernameTF.typeText("RAD")
        
        passwordTF.tap()
        passwordTF.typeText("BlaBl4")
        
        self.app.buttons["loginButton"].tap()
        let infoLabel = self.app.staticTexts["infoLabel"]
        let infoText = ("You got it right :)")
        XCTAssertEqual(infoText, infoLabel.label)
    }
}
