//
//  MainViewModelTest.swift
//  RealTimeTweetsOnMapUIKitTests
//
//  Created by Victor Capilla Developer on 29/8/21.
//

import XCTest
@testable import RealTimeTweetsOnMapUIKit

class MainViewModelTest: XCTestCase {

    var sut: MainViewModel!
    
    override func setUp() {
        
        sut = MainViewModel(APIServiceMock())
    }

    func test_execute_search_action() {
        sut.searchAction("")
        XCTAssertNotNil(sut.location)
        if let coordinate = sut.location?.coordinate {
            XCTAssertEqual(coordinate.latitude, 10.0)
            XCTAssertEqual(coordinate.longitude, 20.0)
        } else {
            XCTAssert(false)
        }
    }
    
    func test_change_life_time() {
        XCTAssertEqual(sut.lifeTime, 5)
        sut.changeLifeTime(1)
        XCTAssertEqual(sut.lifeTime, 10)
        sut.changeLifeTime(2)
        XCTAssertEqual(sut.lifeTime, 15)
        sut.changeLifeTime(3)
        XCTAssertEqual(sut.lifeTime, 15)
    }

}
