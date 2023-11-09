//
//  SwiftUI_Bootcamp_LBTA_UITests.swift
//  SwiftUI_Bootcamp_LBTA_UITests
//
//  Created by Maxim Hranchenko on 09.11.2023.
//

import XCTest

final class SwiftUI_Bootcamp_LBTA_UITests: XCTestCase {
    private let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        
    }
    
    func test_signUp() {
        signUpAndSignIn(isKeyboard: true)
        
        let navBar = app.navigationBars["Welcome."]
        
        XCTAssertTrue(navBar.exists)
    }
    
    func test_notSignUp() {
        signUpAndSignIn(isKeyboard: false)
        
        let navBar = app.navigationBars["Welcome."]
        XCTAssertFalse(navBar.exists)
    }
    
    func test_showAlertExists_FromHomeScreen() {
        signUpAndSignIn(isKeyboard: true)
        
        let alertButton = app.buttons["ShowAlertButton"]
        XCTAssertTrue(alertButton.exists)
        alertButton.tap()
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.exists)
    }
    
    func test_showAlertButton_FromHomeScreen() {
        signUpAndSignIn(isKeyboard: true)
        
        let alertButton = app.buttons["ShowAlertButton"]
        XCTAssertTrue(alertButton.exists)
        alertButton.tap()
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.exists)
        
        let alertOKButton = alert.buttons["OK"]
//        sleep(1)
        let alertOKExists = alertOKButton.waitForExistence(timeout: 5)
        XCTAssertTrue(alertOKExists)
        
        alertOKButton.tap()
        
        let alertExists = alert.waitForExistence(timeout: 5)
//        sleep(1)
        XCTAssertFalse(alertExists)
        XCTAssertFalse(alert.exists)
    }
    
    func test_navigationDestination() {
        signUpAndSignIn(isKeyboard: true)
        
        let destinationButton = app.buttons["Navigate"]
        destinationButton.tap()
        
        let tapText = app.staticTexts["Destination!"]
        XCTAssertTrue(tapText.exists)
        
        let backButtonBar = app.buttons["Welcome."]
        backButtonBar.tap()
        
        let navigationBarTextTap = app.navigationBars["Welcome."].staticTexts["Welcome."]
        navigationBarTextTap.tap()
        
        XCTAssertTrue(navigationBarTextTap.exists)
    }
    
    func test_navigationDestinationAndGoBack() {
        signUpAndSignIn(isKeyboard: true)
        
        let destinationButton = app.buttons["Navigate"]
        destinationButton.tap()
        
        let tapText = app.staticTexts["Destination!"]
        tapText.tap()
        
        XCTAssertTrue(tapText.exists)
    }
}

// MARK: - Extension
private extension SwiftUI_Bootcamp_LBTA_UITests {
    func signUpAndSignIn(isKeyboard: Bool) {
        let textField = app.textFields["TextFieldPlaceholder"]
        textField.tap()
        
        if isKeyboard {
            let mKey = app.keys["M"]
            mKey.tap()
            
            let aKey = app.keys["a"]
            aKey.tap()
            
            let xKey = app.keys["x"]
            xKey.tap()
        }
        
        let returnButton = app.buttons["Return"]
        returnButton.tap()
        
        let signUpButton = app.buttons["SignUpButton"]
        signUpButton.tap()
    }
}
