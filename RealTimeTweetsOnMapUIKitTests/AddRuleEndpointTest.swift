//
//  AddRuleEndpointTest.swift
//  RealTimeTweetsOnMapUIKitTests
//
//  Created by Victor Capilla Developer on 29/8/21.
//

import XCTest
@testable import RealTimeTweetsOnMapUIKit

class AddRuleEndpointTest: XCTestCase {

    var sut: AddRuleEndpoint!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = AddRuleEndpoint("1234")
    }

    func test_geo_endpoint_constructor_with_placeID() {
        XCTAssertEqual(sut.baseURLString, "https://api.twitter.com")
        XCTAssertEqual(sut.method, .post)
        XCTAssertNotNil(sut.headers)
        XCTAssertEqual(sut.headers?.headers.count, 1)
    }

    func test_geo_endpoint_full_constructor() {
        sut = AddRuleEndpoint(baseURLString: "",
                              path: "/2/tweets/search/stream/rules",
                              method: .get,
                              paramEncoding: .JSONEncoding,
                              showDebugInfo: true)
        XCTAssertEqual(sut.baseURLString, "")
        XCTAssertEqual(sut.path, "/2/tweets/search/stream/rules")
        XCTAssertEqual(sut.method, .get)
        XCTAssertNil(sut.headers)
    }

}
