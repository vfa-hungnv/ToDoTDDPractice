//
//  DetailViewControllerTests.swift
//  ToDoTDD
//
//  Created by Hung Nguyen on 8/17/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import XCTest
@testable import ToDoTDD
import CoreLocation

class DetailViewControllerTests: XCTestCase {
    var sut: DetailViewController!
    override func setUp() {
        super.setUp()
        
        let storyboad = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboad.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        _ = sut.view
    }
    
    override func tearDown() {

        super.tearDown()
    }
    
    func test_HasTitleLabel() {
        
        XCTAssertNotNil(sut.titleLabel)
    }
    
    func test_HasMapView() {
        XCTAssertNotNil(sut.mapView)
    }
    
    func testSettingItemInfo_SetTextsToLabels() {
        
        let coordinate = CLLocationCoordinate2D(latitude: 51.2277, longitude: 7.7735)
        let itemManager = ItemManager()
        itemManager.addItem(ToDoItem(title: "The title", itemDescription: "The description", timestamp: 1456150025, location: Location(name: "Home", coordinate: coordinate)))
        sut.itemInfo = (itemManager, 0)
    
        // Trigger call viewWillAppearr() and viewDidAppear and similar methods fo presentation the view
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        
        XCTAssertEqual(sut.titleLabel.text, "The title")
        XCTAssertEqual(sut.dateLabel.text, "02/22/2016")
        XCTAssertEqual(sut.locationLabel.text, "Home")
        XCTAssertEqual(sut.descriptionLabel.text, "The description")
        XCTAssertEqualWithAccuracy(sut.mapView.centerCoordinate.latitude,
                                      coordinate.latitude,
                                      accuracy: 0.001)
    }
    
    func testCheckItem_ChecksItemInItemManager() {
        
        let itemManager = ItemManager()
        itemManager.addItem(ToDoItem(title: "The title"))
        
        sut.itemInfo = (itemManager, 0)
        
        sut.checkItem()
        
        XCTAssertEqual(itemManager.toDoCount, 0)
        XCTAssertEqual(itemManager.doneCount, 1)
    }
}








