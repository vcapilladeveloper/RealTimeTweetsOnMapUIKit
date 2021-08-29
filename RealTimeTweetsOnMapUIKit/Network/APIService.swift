//
//  APIService.swift
//  RealTimeTweetsOnMapUIKit
//
//  Created by Victor Capilla Developer on 29/8/21.
//

import CoreLocation
import Foundation

protocol APIServiceProtocol {
    var returnNewLocation: ((Result<CLLocation, Error>) -> Void) { get set }
    func fecthTweetsWith(_ rule: String)
}

class APIService: NSObject, APIServiceProtocol {

    var returnNewLocation: ((Result<CLLocation, Error>) -> Void) = { _ in  }

    // MARK: - Request Data

    func fecthTweetsWith(_ rule: String) {

        RemoveRuleEndpoint().loadVoidData { [weak self] result in
            switch result {
            case .success():
                self?.addRule(rule)
            case .failure(let error):
                self?.returnNewLocation(.failure(error))
            }
        }
    }

    private func addRule(_ rule: String) {
        AddRuleEndpoint(rule).loadVoidData { [weak self] result in
            switch result {
            case .success():
                self?.streamTweets()
            case .failure(let error):
                self?.returnNewLocation(.failure(error))
            }
        }
    }

    func streamTweets() {
        StreamTweetsEndpoint().listenData(self as URLSessionDataDelegate)
    }

    private func getCoordinates(_ geo: TweetModel.Geo) {
        GeoEndpoint(geo.placeId ?? "").loadData { [weak self] result in
            switch result {
            case .success(let location):
                self?.returnNewLocation(.success(location.coordinates().convertToLocation()))
            case .failure(let error):
                self?.returnNewLocation(.failure(error))
            }
        }
    }

    // MARK: - Helpers

    private func separateDataIntoLinesIfPlaceId(_ data: Data) -> [String] {
        let str = String(decoding: data, as: UTF8.self)
        let lines = str.components(separatedBy: "\n")
        return lines.filter { $0.contains("place_id") }
    }

    private func decodeData(_ item: String) -> TweetModel? {
        do {
            return try JSONDecoder().decode(TweetModel.self, from: item.data(using: .utf8) ?? Data())
        } catch {
            return nil
        }
    }

}

    // MARK: - Methods for apply URLSessionDataDelegate
extension APIService: URLSessionDataDelegate {

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        separateDataIntoLinesIfPlaceId(data).forEach { item in
            if let tweet = decodeData(item) {
                if let geo = tweet.data.geo {
                    getCoordinates(geo)
                }
            }
        }
    }

    func urlSession(_ session: URLSession,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        guard challenge.previousFailureCount == 0 else {
            challenge.sender?.cancel(challenge)
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        let allowAllCredential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
        completionHandler(.useCredential, allowAllCredential)
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            returnNewLocation(.failure(error))
        }
    }

}
