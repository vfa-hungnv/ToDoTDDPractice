//
//  InputViewControllerTests.swift
//  ToDoTDD
//
//  Created by Hung Nguyen on 8/18/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import XCTest
@testable import ToDoTDD
import CoreLocation

class InputViewControllerTests: XCTestCase {
    
    var sut: InputViewController!
    var placemark: MockPlacemark!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewControllerWithIdentifier("InputViewController") as! InputViewController
        _ = sut.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_HasTextField() {
        
        XCTAssertNotNil(sut.titleTextField)
        XCTAssertNotNil(sut.dateTextField)
        XCTAssertNotNil(sut.locationTextField)
        XCTAssertNotNil(sut.addressTextField)
        XCTAssertNotNil(sut.descriptionTextField)
        XCTAssertNotNil(sut.saveButton)
        XCTAssertNotNil(sut.cancelButton)
    }
    
    func testSave_UserGeocoderToGetCoordinateFromAdress() {
        sut.titleTextField.text = "Test Title"
        sut.dateTextField.text = "02/22/2016"
        sut.locationTextField.text = "Office"
        sut.addressTextField.text = "Infinite Loop 1, Cupertino"
        sut.descriptionTextField.text = "Test description"
        
        // Dependency injection
        // inject the instance from the test that should be used to fetch the coordinate for the given address
        let mockGeocoder = MockGeocoder()
        sut.geocoder = mockGeocoder
        
        sut.itemManager = ItemManager()
        sut.save()
        
        placemark = MockPlacemark()
        let coordinate = CLLocationCoordinate2D(latitude: 37.3316851, longitude: -122.0300764)
        placemark.mockCoordinate = coordinate
        mockGeocoder.completionHander?([placemark], nil)
        let item = sut.itemManager?.itemAtIndex(0)
        
        let testItem = ToDoItem(title: "Test Title",
                                itemDescription: "Test description",
                                timestamp: 1456095600,
                                location: Location(name: "Office", coordinate: coordinate))
        

        XCTAssertEqual(item, testItem)

    }
    
    func testSave_CreatesToDoItemWithTitleDateAndDescription() {
        sut.titleTextField.text = "Test Title"
        sut.dateTextField.text = "02/22/2016"
        sut.descriptionTextField.text = "Test Description"
        
        sut.itemManager = ItemManager()
        
        sut.save()
        
        let item = sut.itemManager?.itemAtIndex(0)
        
        let testItem = ToDoItem(title: "Test Title",
                                itemDescription: "Test Description",
                                timestamp: 1456095600,
                                location: nil)
        
        XCTAssertEqual(item, testItem)
    }
    
    func test_SaveButtonHasSaveAction(){
        let saveButton: UIButton = sut.saveButton
        
        guard let actions = saveButton.actionsForTarget(sut, forControlEvent: .TouchUpInside) else {
            XCTFail(); return
        }
        XCTAssertTrue(actions.contains("save"))
    }
    
//    func test_GeocoderWorkAsExpected() {
//        
//        let expectation = expectationWithDescription("Wait for geocode")
//        
//        //This method call is asynchronous, the closure is called sometime in the future on a different thread
//        CLGeocoder().geocodeAddressString("Infinite Loop 1, Cupertine") {
//            (placemarks, error) -> Void in
//            let placemark = placemarks?.first
//            let coordinate = placemark?.location?.coordinate
//            
//            guard let latitude = coordinate?.latitude else {
//                XCTFail(); return
//            }
//            
//            guard let longitude = coordinate?.longitude else {
//                XCTFail(); return
//            }
//            
//            XCTAssertEqualWithAccuracy(latitude, 37.3316851, accuracy: 0.00001)
//            XCTAssertEqualWithAccuracy(longitude, -122.030127, accuracy: 0.00001)
//            
//            expectation.fulfill()
//        }
//        waitForExpectationsWithTimeout(5, handler: nil)
//    }
    
}

extension InputViewControllerTests {
    class MockGeocoder: CLGeocoder {
        var completionHander: CLGeocodeCompletionHandler?
        
        override func geocodeAddressString(addressString: String, completionHandler: CLGeocodeCompletionHandler) {
            self.completionHander = completionHandler
        }
    }
    
    class MockPlacemark: CLPlacemark {
        var mockCoordinate: CLLocationCoordinate2D?
    
        override var location: CLLocation? {
            guard let coordinate = mockCoordinate else { return CLLocation() }
            return CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        }
    }
}











