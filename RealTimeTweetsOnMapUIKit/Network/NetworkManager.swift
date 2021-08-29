//
//  NetworkManager.swift
//  RealTimeTweetsOnMapUIKit
//
//  Created by Victor Capilla Developer on 29/8/21.
//

import Foundation


public typealias NetworkResult<T: Codable> = Result<T, Error>

open class NetworkManager {
    
    // TODO: Depenency Injection for URLSession and URLSessionDataTask to make more Testable with Mocks
    static var defaultSession: URLSession = .shared
    static var dataTask: URLSessionDataTask?
    
    public static func requestData<T, E: Endpoint>(_ endpoint: E, completion: @escaping (NetworkResult<T>) -> Void)  {
        
        guard let url = URL(string: endpoint.getStringURL()) else {
            fatalError("Could not create URL from the given URL components.")
        }
        
        dataTask?.cancel()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        
        // TODO: Make the serialization inside the Endpoint Extension
        if let params = endpoint.parameters {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                urlRequest.httpBody = jsonData
            } catch (let formatError) {
                completion(.failure(formatError))
            }
        }
        
        if let header = endpoint.headers {
            urlRequest.allHTTPHeaderFields = header.dictionary
        }
        
        dataTask = defaultSession.dataTask(with: urlRequest, completionHandler: { data, response, error in
            if let error = error  {
                completion(.failure(error))
            }
            if let data = data {
                //TODO: Make the decoder outside request.
                do {
                    let parsedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(parsedData))
                } catch (let fError) {
                    print(fError)
                    completion(.failure(fError))
                }
            }
        })
        do {dataTask?.resume()}
    }

    public static func listenData<E: Endpoint>(_ endpoint: E, delegate: URLSessionDelegate)  {
        guard let url = URL(string: endpoint.getStringURL()) else {
            fatalError("Could not create URL from the given URL components.")
        }
        dataTask?.cancel()
        var urlRequest = URLRequest(url: url,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: .infinity)
       
        
        urlRequest.httpMethod = endpoint.method.rawValue
                
        if let header = endpoint.headers {
            urlRequest.allHTTPHeaderFields = header.dictionary
        }
        
        urlRequest.timeoutInterval = .infinity
        let session = URLSession(configuration: .default, delegate: delegate, delegateQueue: .main)
        
        let dataTask = session.dataTask(with: urlRequest)

        do {dataTask.resume()}
    }
    
}

private extension NetworkManager {
    
    /// Create URLRequest from endpoint
    /// - Returns: URLRequest
    static func makeRequest<E: Endpoint>(_ endpoint: E) -> URLRequest {
        
        // URL
        guard let url = URL(string: endpoint.baseURLString + endpoint.path) else { fatalError("Endpoint URL is invalid") }
        var request = URLRequest(url: url)
        
        // Method
        request.httpMethod = endpoint.method.rawValue
        
        // Headers
        request.allHTTPHeaderFields = endpoint.headers?.dictionary
        
        // Parameters
        if let params = endpoint.paramEncoding {
            switch params {
            case .URLEncoding:
                var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
                components?.queryItems = endpoint.parameters?.map({
                    URLQueryItem(name: $0.key, value: "\($0.value)")
                })
                request.url = components?.url
                
            case .JSONEncoding:
                if let params = endpoint.parameters {
                    request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                }
                
            case .noEncoding:
                request.httpBody = endpoint.body
                
            }
        }
        
        return request
        
    }
}
