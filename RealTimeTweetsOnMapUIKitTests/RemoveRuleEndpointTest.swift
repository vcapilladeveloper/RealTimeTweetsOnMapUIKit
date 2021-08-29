//
//  RemoveRuleEndpointTest.swift
//  RealTimeTweetsOnMapUIKitTests
//
//  Created by Victor Capilla Developer on 29/8/21.
//

import XCTest
@testable import RealTimeTweetsOnMapUIKit

class RemoveRuleEndpointTest: XCTestCase {

    var sut: RemoveRuleEndpoint!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = RemoveRuleEndpoint()
    }

    func test_geo_endpoint_constructor_with_placeID() {
        XCTAssertEqual(sut.baseURLString, "https://api.twitter.com")
        XCTAssertEqual(sut.method, .post)
        XCTAssertNotNil(sut.headers)
    }

    func test_geo_endpoint_full_constructor() {
        sut = RemoveRuleEndpoint(baseURLString: "",
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
