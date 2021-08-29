//
//  GeoModelTest.swift
//  RealTimeTweetsOnMapUIKitTests
//
//  Created by Victor Capilla Developer on 29/8/21.
//

import XCTest
@testable import RealTimeTweetsOnMapUIKit

class GeoModelTest: XCTestCase {

    var sut: GeoModel!
    
    override func setUp() {
        sut = GeoModel(id: "", fullName: "", country: "", centroid: [12.3, 45.6])
    }

    func test_coordinates_converter() {
        let coordinates = sut.coordinates()
        XCTAssertEqual(coordinates.latitude, 45.6)
        XCTAssertEqual(coordinates.longitude, 12.3)
    }

}
