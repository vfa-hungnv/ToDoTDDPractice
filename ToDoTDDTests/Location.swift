//
//  Location.swift
//  ToDoTDD
//
//  Created by Hung Nguyen on 8/12/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import XCTest
@testable import ToDoTDD
import CoreLocation

class LocationTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit_ShouldSetNameAndCoordinate() {
        let testCoordinate = CLLocationCoordinate2D(latitude: 1, longitude: 2)
        let location = Location(name: "", coordinate: testCoordinate)
        XCTAssertEqual(location.coordinate?.longitude, testCoordinate.longitude)
        XCTAssertEqual(location.coordinate?.latitude, testCoordinate.latitude)
    }
    
    func testInit_ShouldSerName() {
        let location = Location(name: "Test name")
        XCTAssertEqual(location.name, "Test name 2222", "Initializer should set the name")
    }
    
    func testWhenlatitudeDifferes_ShouldBeNotEqual() {
        performNotEqualTestWithLocationProperties("Home", secondName: "Vila", firstLongLat: (1.0, 0.0), secondLongLat: (0.0, 0.0), line: #line )
    }
    
    func testWhenLongtitudeDifferes_ShoulBeNotEuqual() {
        performNotEqualTestWithLocationProperties("Home", secondName: "Vila", firstLongLat: (1.0, 1.0), secondLongLat: (1.0, 0.0), line: #line )
    }
    
    func testWhenOneHasCoordinateAndTheOtherDoesnot_ShouldBeNotEqual() {
        performNotEqualTestWithLocationProperties("Home", secondName: "Vila", firstLongLat: (0.0, 0.0), secondLongLat: nil)
    }
    
    func testWhenNameDifferes_ShouldBeNotEqual() {
        performNotEqualTestWithLocationProperties("Home", secondName: "vila", firstLongLat: nil, secondLongLat: nil)
    }
    
    func performNotEqualTestWithLocationProperties(firstName: String,
                                                   secondName: String,
                                                   firstLongLat: (Double, Double)?,
                                                   secondLongLat: (Double, Double)?,
                                                   line: UInt = #line) {
        
        let firstCoord: CLLocationCoordinate2D?
        if let firstLongLat = firstLongLat {
            firstCoord = CLLocationCoordinate2D(latitude: firstLongLat.0, longitude: firstLongLat.1)
        } else {
            firstCoord = nil
        }
        let firstLocation = Location(name: firstName, coordinate: firstCoord)
        
        let secondCoord: CLLocationCoordinate2D?
        if let secondLongLat = secondLongLat {
            secondCoord = CLLocationCoordinate2D(latitude: secondLongLat.0, longitude: secondLongLat.1)
        } else {
            secondCoord = nil
        }
        let secondLocation = Location(name: secondName, coordinate: secondCoord)
        
        XCTAssertNotEqual(firstLocation, secondLocation, line: line)
        
    }
    
}






