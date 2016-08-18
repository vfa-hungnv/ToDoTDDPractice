//
//  ItemManagerTests.swift
//  ToDoTDD
//
//  Created by Hung Nguyen on 8/15/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import XCTest
@testable import ToDoTDD

class ItemManagerTests: XCTestCase {
    var sut: ItemManager!
    override func setUp() {
        super.setUp()
        sut = ItemManager()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testToDoCount_Initially_ShouldBeZero() {
        
        
        XCTAssertEqual(sut.toDoCount, 0, "Initially todDo Count should be 0")
    }
    func testDoneCount_Initially_ShouldBeZero() {
        
        
        XCTAssertEqual(sut.doneCount, 0, "Initially done count should be 0")
    }
    
    func testToDoCount_AfterAddingOneItem_IsOne() {
        sut.addItem(ToDoItem(title: "Test title"))
    
        XCTAssertEqual(sut.toDoCount, 1, "toDoCount should be 1")
    }
    
    func testItemAtIndex_ShouldReturnPreviouslyAddedItem() {
        let item = ToDoItem(title: "Test title")
        sut.addItem(item)
        
        let returnedItem = sut.itemAtIndex(0)
        
        XCTAssertEqual(item.title, returnedItem.title, "Should be the same item")
    }
    
    func testCheckingItem_ChangesCountOfToDoAndOfDoneItems() {
        sut.addItem(ToDoItem(title: "First item"))
        sut.checkItemAtIndex(0)
        
        XCTAssertEqual(sut.toDoCount, 0, "Todo count should  be 0")
        XCTAssertEqual(sut.doneCount, 1, "Done count should be 1")
    }
    
    func testCheckingItem_RemovesItFromTheToDoItemList() {
        let firstItem = ToDoItem(title: "First")
        let secondItem = ToDoItem(title: "Second")
        
        sut.addItem(firstItem)
        sut.addItem(secondItem)
        
        sut.checkItemAtIndex(0)
        
        XCTAssertEqual(sut.itemAtIndex(0).title, secondItem.title)
        
    }
    
    func testDoneItemAtIndex_ShouldReturnPreviouslyCheckedItem() {
        let item = ToDoItem(title: "Item")
        sut.addItem(item)
        sut.checkItemAtIndex(0)
        
        let returnedItem = sut.doneItemAtIndex(0)
        
        XCTAssertEqual(item.title, returnedItem.title)
    }
    
    func testRemoveAllItems_ShouldResultInCountBeZero() {
        sut.addItem(ToDoItem(title: "first"))
        sut.addItem(ToDoItem(title: "Second"))
        sut.checkItemAtIndex(0)
        
        XCTAssertEqual(sut.toDoCount, 1, "To do count should equal 1")
        XCTAssertEqual(sut.doneCount, 1, "Done count should equal 1")
        
        sut.removeAllItems()
        XCTAssertEqual(sut.toDoCount, 0, "todo count should equal 0")
        XCTAssertEqual(sut.doneCount, 0, "Done count should equal 0")
    }
    
    func testAddingTheSameItem_DoesNotIncreaseCount() {
        sut.addItem(ToDoItem(title: "first"))
        sut.addItem(ToDoItem(title: "first"))
        
        XCTAssertEqual(sut.toDoCount, 1)
    }
}

















