//
//  ItemListDataProviderTests.swift
//  ToDoTDD
//
//  Created by Hung Nguyen on 8/16/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import XCTest
@testable import ToDoTDD

class ItemListDataProviderTests: XCTestCase {
    var sut: ItemListDataProvider!
    var tableView: UITableView!
    var controller: ItemListViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = ItemListDataProvider()
        sut.itemManage = ItemManager()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewControllerWithIdentifier("ItemListViewController") as! ItemListViewController
        _ = controller.view
        
        tableView = controller.tableView
        tableView.dataSource = sut
        tableView.delegate = sut
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNumberOfSections_IsTwo() {

        
        let numberOfSections = tableView.numberOfSections
        
        XCTAssertEqual(numberOfSections, 2)
    }
    
    func testNumberRowsInFirstSection_IsToDoCount() {

        sut.itemManage?.addItem(ToDoItem(title: "First"))
        
        XCTAssertEqual(tableView.numberOfRowsInSection(0), 1)

        sut.itemManage?.addItem(ToDoItem(title: "second"))
        tableView.reloadData()
    
        XCTAssertEqual(tableView.numberOfRowsInSection(0), 2)
    }
    
    func testNumberRowsInSecondSection_IsDoneCount() {
        
        sut.itemManage?.addItem(ToDoItem(title: "First"))
        sut.itemManage?.addItem(ToDoItem(title: "Second"))
        sut.itemManage?.checkItemAtIndex(0)
        
        XCTAssertEqual(tableView.numberOfRowsInSection(1), 1)
        
        sut.itemManage?.checkItemAtIndex(0)
        
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfRowsInSection(1), 2)
    }
    
    func testCellForRow_ReturnItemCell() {
        sut.itemManage?.addItem(ToDoItem(title: "First"))
        tableView.reloadData()

        
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))
        
        XCTAssertTrue(cell is ItemCell)
    }
    
    func testCellForRow_DequeuesCell() {
        let mockTableView = MockTableView().mockTableViewWithDataSource(sut)
        
        sut.itemManage?.addItem(ToDoItem(title: "First"))
        mockTableView.reloadData()
        _ = mockTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))
        
        XCTAssertTrue(mockTableView.cellGotDequeued)
    }
    
    func testConfigCell_GetCalledInCellForRow() {
        let mockTableView = MockTableView().mockTableViewWithDataSource(sut)
        
        let toDoItem = ToDoItem(title: "First", itemDescription: "First description")
        sut.itemManage?.addItem(toDoItem)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! MockItemCell
        
        XCTAssertEqual(cell.toDoItem, toDoItem)
    }
    
    func testDeletionButtonInFirstSection_ShowsTitleCheck() {
        let deleteButtonTitle = tableView.delegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        XCTAssertEqual(deleteButtonTitle, "Check")
    }
    
    func testDeletionButtonInSecondSection_ShowTitleUncheck() {
        let deleteButtonTitle = tableView.delegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 1))
        XCTAssertEqual(deleteButtonTitle, "Uncheck")
    }
    
    func testDataSourceAndDelegate_AreTheSameObject() {
        XCTAssert(tableView.dataSource is ItemListDataProvider)
        XCTAssert(tableView.delegate is ItemListDataProvider)
        
        XCTAssertEqual(tableView.dataSource as? ItemListDataProvider,
                          tableView.delegate as? ItemListDataProvider)
    }
    
    func testCheckingAnItem_ChecksItInTheItemManager() {
        sut.itemManage?.addItem(ToDoItem(title: "First"))
        tableView.dataSource?.tableView?(tableView, commitEditingStyle: .Delete, forRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        XCTAssertEqual(sut.itemManage?.toDoCount, 0)
        XCTAssertEqual(sut.itemManage?.doneCount, 1)
        XCTAssertEqual(tableView.numberOfRowsInSection(0), 0)
        XCTAssertEqual(tableView.numberOfRowsInSection(1), 1)
    }
    
    func testUncheckingAnItem_UncheckItInTheItemsManager() {
        sut.itemManage?.addItem(ToDoItem(title: "First"))
        sut.itemManage?.checkItemAtIndex(0)

        tableView.dataSource?.tableView?(tableView, commitEditingStyle: .Delete, forRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 1))
        
        XCTAssertEqual(sut.itemManage?.toDoCount, 1)
        XCTAssertEqual(sut.itemManage?.doneCount, 0)
        XCTAssertEqual(tableView.numberOfRowsInSection(0), 1)
        XCTAssertEqual(tableView.numberOfRowsInSection(1), 0)
    }
}


extension ItemListDataProviderTests {
    
    class MockTableView: UITableView {
        var cellGotDequeued = false
        
        override func dequeueReusableCellWithIdentifier(identifier: String, forIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            cellGotDequeued = true
            
            return super.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
        }
        
        func mockTableViewWithDataSource(dataSource: UITableViewDataSource) -> MockTableView {
            let mockTableView = MockTableView(frame: CGRect(x: 0, y: 0, width: 320, height: 480), style: .Plain)
            mockTableView.dataSource = dataSource
            mockTableView.registerClass(MockItemCell.self, forCellReuseIdentifier: "ItemCell")
            
            return mockTableView
        }
    }
    
    class MockItemCell: ItemCell {
        var toDoItem: ToDoItem?
        
        override func configCellWithItem(item: ToDoItem, checked: Bool = false) {
            toDoItem = item
        }
    }
}
















