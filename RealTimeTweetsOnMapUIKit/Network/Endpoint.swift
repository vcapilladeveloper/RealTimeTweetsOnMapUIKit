//
//  Endpoint.swift
//  RealTimeTweetsOnMapUIKit
//
//  Created by Victor Capilla Developer on 29/8/21.
//

import Foundation

public protocol Endpoint {
    associatedtype  T
    
    var baseURLString: String { get }
    
    var path: String { get }
    
    var method: HttpMethod { get }
    
    var headers: HttpHeaders? { get }
    
    var parameters: [String: Any]? { get }
    
    var body: Data? { get }
    
    var paramEncoding: ParameterEncoding? { get }
    
    var showDebugInfo: Bool { get }
    
}

public extension Endpoint {
    
    func getStringURL() -> String {
        baseURLString + path
    }
    
    func loadData(_ completion: @escaping (NetworkResult<T>) -> Void) where T: Codable {
        NetworkManager.requestData(self, completion: completion)
    }
    
    func listenData(_ delegate: URLSessionDelegate) {
        NetworkManager.listenData(self, delegate: delegate)
    }
        
}
