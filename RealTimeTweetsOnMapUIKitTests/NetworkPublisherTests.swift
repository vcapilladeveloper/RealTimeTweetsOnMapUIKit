//
// NetworkPublisherTests.swift
// NetworkPublisherTests
//
//  Created by Victor Capilla Developer on 27/8/21.
//

import XCTest

@testable import RealTimeTweetsOnMapUIKit

final class NetworkPublisherTests: XCTestCase {
    
    func testGetExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        //        XCTAssertEqual(KpiNetworkManager().text, "Hello, World!")
        // https://swapi.dev/api/starships/9/
        
        
        let expectation = self.expectation(description: "Wait for \("https://jsonplaceholder.typicode.com/todos/1") to load.")
        let exampleEndpoint = ExampleGetEndpoint(baseURLString: "https://jsonplaceholder.typicode.com", path: "/todos/1", method: .get, showDebugInfo: true)
        exampleEndpoint.loadData() { result in
            switch result {
            case .success(let data):
                print(data)
                XCTAssertEqual(1, data.id)
            case .failure(let newError):
                print(newError.localizedDescription)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(true)
    }
    
    func testPostExample() {
        let expectation = self.expectation(description: "Wait for \("https://jsonplaceholder.typicode.com/todos") to load.")
        let exampleEndpoint = ExamplePostEndpoint(baseURLString: "https://jsonplaceholder.typicode.com", path: "/todos", method: .post, headers: ["Content-Type": "application/json"],parameters: ["userId": 1, "title": "Prueba", "completed": false] ,showDebugInfo: true)
        exampleEndpoint.loadData() { result in
            switch result {
            case .success(let data):
                print(data)
                XCTAssertEqual(201, data.id)
                XCTAssertEqual(1, data.userId)
                XCTAssertEqual("Prueba", data.title)
                XCTAssertEqual(false, data.completed)
            case .failure(let newError):
                print(newError.localizedDescription)
                XCTAssert(false)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(true)
    }
    
    func testPutExample() {
        let expectation = self.expectation(description: "Wait for \("https://jsonplaceholder.typicode.com/todos") to load.")
        let exampleEndpoint = ExamplePostEndpoint(baseURLString: "https://jsonplaceholder.typicode.com", path: "/todos/200", method: .put, headers: ["Content-Type": "application/json"],parameters: ["userId": 1, "title": "Prueba 2", "completed": false] ,showDebugInfo: true)
        exampleEndpoint.loadData() { result in
            switch result {
            case .success(let data):
                print(data)
                XCTAssertEqual(200, data.id)
                XCTAssertEqual(1, data.userId)
                XCTAssertEqual("Prueba 2", data.title)
                XCTAssertEqual(false, data.completed)
            case .failure(let newError):
                print(newError.localizedDescription)
                XCTAssert(false)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(true)
    }
    
    func testPatchTitleExample() {
        let expectation = self.expectation(description: "Wait for \("https://jsonplaceholder.typicode.com/todos") to load.")
        let exampleEndpoint = ExamplePostEndpoint(baseURLString: "https://jsonplaceholder.typicode.com", path: "/todos/200", method: .patch, headers: ["Content-Type": "application/json"],parameters: ["title": "Prueba 3"] ,showDebugInfo: true)
        exampleEndpoint.loadData() { result in
            switch result {
            case .success(let data):
                print(data)
                XCTAssertEqual(200, data.id)
                XCTAssertEqual(10, data.userId)
                XCTAssertEqual("Prueba 3", data.title)
                XCTAssertEqual(false, data.completed)
            case .failure(let newError):
                print(newError.localizedDescription)
                XCTAssert(false)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(true)
    }
    
    func testPatchCompletedExample() {
        let expectation = self.expectation(description: "Wait for \("https://jsonplaceholder.typicode.com/todos") to load.")
        let exampleEndpoint = ExamplePostEndpoint(baseURLString: "https://jsonplaceholder.typicode.com", path: "/todos/200", method: .patch, headers: ["Content-Type": "application/json"],parameters: ["completed": true] ,showDebugInfo: true)
        exampleEndpoint.loadData() { result in
            switch result {
            case .success(let data):
                print(data)
                XCTAssertEqual(200, data.id)
                XCTAssertEqual(10, data.userId)
                XCTAssertEqual("ipsam aperiam voluptates qui", data.title)
                XCTAssertEqual(true, data.completed)
            case .failure(let newError):
                print(newError.localizedDescription)
                XCTAssert(false)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(true)
    }
    
    func testDeleteExample() {
        let expectation = self.expectation(description: "Wait for \("https://jsonplaceholder.typicode.com/todos/200") to load.")
        let exampleEndpoint = ExampleDeleteEndpoint(baseURLString: "https://jsonplaceholder.typicode.com", path: "/todos/200", method: .delete, showDebugInfo: true)
        exampleEndpoint.loadData() { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let newError):
                print(newError.localizedDescription)
                XCTAssert(false)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(true)
    }
}
