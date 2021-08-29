//
//  APIServiceMock.swift
//  RealTimeTweetsOnMapUIKitTests
//
//  Created by Victor Capilla Developer on 29/8/21.
//

import XCTest
import CoreLocation
@testable import RealTimeTweetsOnMapUIKit


class APIServiceMock: NSObject, APIServiceProtocol {
    var returnNewLocation: ((Result<CLLocation, Error>) -> Void) = { _ in  }
    
    func fecthTweetsWith(_ rule: String) {
        returnNewLocation(.success(CLLocation(latitude: 10.0, longitude: 20.0)))
    }
    
    
}
