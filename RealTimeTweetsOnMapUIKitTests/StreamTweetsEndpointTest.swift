//
//  StreamTweetsEndpointTest.swift
//  RealTimeTweetsOnMapUIKitTests
//
//  Created by Victor Capilla Developer on 29/8/21.
//

import XCTest
@testable import RealTimeTweetsOnMapUIKit

class StreamTweetsEndpointTest: XCTestCase {

    var sut: StreamTweetsEndpoint!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = StreamTweetsEndpoint()
    }
    
    func test_geo_endpoint_constructor_with_placeID() {
        XCTAssertEqual(sut.baseURLString, "https://api.twitter.com")
        XCTAssertEqual(sut.method, .get)
        XCTAssertNotNil(sut.headers)
    }
    
    func test_geo_endpoint_full_constructor() {
        sut = StreamTweetsEndpoint(baseURLString: "", path: "/2/tweets/search/stream?tweet.fields=geo", method: .post, paramEncoding: .JSONEncoding, showDebugInfo: true)
        XCTAssertEqual(sut.baseURLString, "")
        XCTAssertEqual(sut.path, "/2/tweets/search/stream?tweet.fields=geo")
        XCTAssertEqual(sut.method, .post)
        XCTAssertNil(sut.headers)
    }
}
