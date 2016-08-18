//
//  ToDoItemTests.swift
//  ToDoTDD
//
//  Created by Hung Nguyen on 8/12/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import XCTest
@testable import ToDoTDD

class ToDoItemTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit_ShouldSetTitle() {
        let item = ToDoItem(title: "Test title")
        XCTAssertEqual(item.title, "Test title", "Initializer should set the item title")
        
    }
    
    func testInit_ShouldSetTileAndDescription() {
        let item = ToDoItem(title: "Test title", itemDescription: "Test description")
        XCTAssertEqual(item.itemDescription, "Test description", "Initializer should set the item desciption")
    }
    
    func testInit_ShouldSetTitleAndDescriotionAndTimestamp() {
        let item = ToDoItem(title: "Test title", itemDescription: "Test description", timestamp: 0.0)
        XCTAssertEqual(0.0, item.timestamp, "Initializer should set the timestamp")
    }
    
    func testInit_ShouldSetTitleAndDesciptionAndTimestampAndLocation() {
        let location = Location(name: "Test name")
        let item = ToDoItem(title: "Test title", itemDescription: "Test description", timestamp: 0.0, location: location)
        
        XCTAssertEqual(location.name, item.location?.name, "Initilizer should set the location")
    }
    
    func testEqualItems_ShouldBeEqual() {
        let firstItem = ToDoItem(title: "First")
        let seconditem = ToDoItem(title: "First")
        
        XCTAssertEqual(firstItem, seconditem)
    }
    
    func testDiffirentItems_ShoudNotEqual() {
        let firstItem = ToDoItem(title: "firstItem", itemDescription: "FirstItemDescription", timestamp: 0.0, location: Location(name: "Home"))
        let secondItem = ToDoItem(title: "secondItem", itemDescription: "SecondItemDescription", timestamp: 0.0, location: Location(name: "Hotel"))
        
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    func testWhenOneLocationIsNilAndTheOtherIsnt_ShouldBeNotEqual() {
        var firstItem = ToDoItem(title: "First title",
                                 itemDescription: "First description",
                                 timestamp: 0.0, location: nil)
        var secondItem = ToDoItem(title: "First title",
                                  itemDescription: "First desciption",
                                  timestamp: 0.0,
                                  location: Location(name: "office") )
        
        XCTAssertNotEqual(firstItem, secondItem)
        
        firstItem = ToDoItem(title: "First title",
                             itemDescription: "First description",
                             timestamp: 0.0,
                             location: Location(name: "Home"))
        secondItem = ToDoItem(title: "First title",
                              itemDescription: "First description",
                              timestamp: 0.0,
                              location: nil)
        
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    func testWhenTimestampDifferes_ShoulNotBeEqual() {
        let firstItem = ToDoItem(title: "Home",
                                 itemDescription: "Homo desception", timestamp: 1.0, location: nil)
        let secondItem = ToDoItem(title: "Vila",
                                  itemDescription: "Homo desception", timestamp: 0.0, location: nil)
        
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    func testWhenDescriptionDifferes_ShouldBeNotEqual() {
        let firstItem = ToDoItem(title: "Home",
                                 itemDescription: "Homo desception")
        let secondItem = ToDoItem(title: "Vila",
                                  itemDescription: "Vila desception")
        
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    func testWhenTitleDifferes_ShouldbeNotEqual() {
        let firstItem = ToDoItem(title: "Home",
                                 itemDescription: "Vila desception")
        let secondItem = ToDoItem(title: "Vila",
                                  itemDescription: "Vila desception")
        
        XCTAssertNotEqual(firstItem, secondItem)
    }
}




