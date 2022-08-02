//
//  Lululemon_DemoTests.swift
//  Lululemon DemoTests
//
//  Created by Franco Fantillo on 2022-08-01.
//

import XCTest
import Foundation
@testable import Lululemon_Demo

class Lululemon_DemoTests: XCTestCase {
    
    var test_content_view_model: ContentView.ContentViewModel!
    var test_garmentSorter: GarmentSorter!

    override func setUpWithError() throws {
        test_content_view_model = ContentView.ContentViewModel(garmentSource: MockDBHelper())
        test_garmentSorter = GarmentSorter()
    }

    override func tearDownWithError() throws {
        test_content_view_model = nil
        test_garmentSorter = nil
    }

    func test_content_view() throws {
        
        XCTAssertEqual(test_content_view_model.garments.count, 3)
        print(test_content_view_model.garments[2].name)
        XCTAssert(test_content_view_model.garments[2].name == "Shirt")
        XCTAssert(Calendar.current.component(.year, from: test_content_view_model.garments[2].creationDate) == 1980)

        
        print(test_content_view_model.garments[1].name)
        XCTAssert(test_content_view_model.garments[1].name == "Pants")
        XCTAssert(Calendar.current.component(.year, from: test_content_view_model.garments[1].creationDate) == 2000)

        print(test_content_view_model.garments[0].name)
        XCTAssert(test_content_view_model.garments[0].name == "Apple")
        XCTAssert(Calendar.current.component(.year, from: test_content_view_model.garments[0].creationDate) == 2020)
    }

    func test_sorter_alpha() throws {
        
        let garments = test_garmentSorter.sortGarments(isSortedAlpha: true, garments: test_content_view_model.garments)
        XCTAssert(garments[0].name == "Apple")
        XCTAssert(garments[1].name == "Pants")
        XCTAssert(garments[2].name == "Shirt")
    }
    
    func test_sorter_date() throws {
        let garments = test_garmentSorter.sortGarments(isSortedAlpha: false, garments: test_content_view_model.garments)
        XCTAssert(Calendar.current.component(.year, from: garments[0].creationDate) == 1980)
        XCTAssert(Calendar.current.component(.year, from: garments[1].creationDate) == 2000)
        XCTAssert(Calendar.current.component(.year, from: garments[2].creationDate) == 2020)
    }
}
