//
//  ToDoTDDUITests.swift
//  ToDoTDDUITests
//
//  Created by Hung Nguyen on 8/19/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import XCTest

class ToDoTDDUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        
        let app = XCUIApplication()
        let titleElement = app.otherElements.containingType(.TextField, identifier:"Title").element
        titleElement.tap()
        titleElement.tap()
        titleElement.tap()
        
        let descriptionTextField = app.textFields["Description"]
        descriptionTextField.tap()
        app.textFields["Description"]
        descriptionTextField.tap()
        app.textFields["Description"]
        descriptionTextField.tap()
        app.textFields["Description"]
        titleElement.tap()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
