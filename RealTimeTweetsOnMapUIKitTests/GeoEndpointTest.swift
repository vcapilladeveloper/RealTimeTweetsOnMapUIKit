//
//  GeoEndpoint.swift
//  RealTimeTweetsOnMapUIKitTests
//
//  Created by Victor Capilla Developer on 29/8/21.
//

import XCTest
@testable import RealTimeTweetsOnMapUIKit

class GeoEndpointTest: XCTestCase {

    var sut: GeoEndpoint!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = GeoEndpoint("1234")
    }

    func test_geo_endpoint_constructor_with_placeID() {
        XCTAssertEqual(sut.baseURLString, "https://api.twitter.com")
        XCTAssertEqual(sut.method, .get)
        XCTAssertNotNil(sut.headers)
    }

    func test_geo_endpoint_full_constructor() {
        sut = GeoEndpoint(baseURLString: "",
                          path: "/1.1/geo/id/",
                          method: .post,
                          paramEncoding: .JSONEncoding,
                          showDebugInfo: true)
        XCTAssertEqual(sut.baseURLString, "")
        XCTAssertEqual(sut.path, "/1.1/geo/id/")
        XCTAssertEqual(sut.method, .post)
        XCTAssertNil(sut.headers)
    }
}
