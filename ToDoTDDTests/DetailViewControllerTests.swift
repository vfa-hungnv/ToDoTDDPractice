//
//  DetailViewControllerTests.swift
//  ToDoTDD
//
//  Created by Hung Nguyen on 8/17/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import XCTest
@testable import ToDoTDD

class DetailViewControllerTests: XCTestCase {
    var sut: DetailViewController!
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboad = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboad.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        _ = sut.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_HasTitleLabel() {

        
        XCTAssertNotNil(sut.titleLabel)
    }
    
}
