//
//  NetworkTests.swift
//  SephoraExercice
//
//  Created by Firas on 27/09/2023.
//

@testable import Platform
@testable import Domain
import Foundation
import OHHTTPStubsSwift
import OHHTTPStubs
import XCTest
import Combine


final class NetworkTests: XCTestCase {
    private let stubURL = "www.url.com"
    
    var cancellables: Set<AnyCancellable> = []
    var sut: Network!
    
    override func setUp() {
        super.setUp()
        sut = Network()
    }

    func test_APIRepo_Success() {
        // arrange
        let dataFile = "products.json"
        //act
        stub(condition: isHost(stubURL)) { request in
            return OHHTTPStubs.HTTPStubsResponse(
                fileAtPath: OHPathForFile(dataFile, type(of: self))!,
                statusCode: 200,
                headers: nil
            )
        }
        let publisher: AnyPublisher<[MockItemDecodable], Error> = sut.request(.fake())

        let result = expectValue(of: publisher.map{$0[0].id},
                                 equals: [ { value in value == 1234678 } ])
        let result1 = expectValue(of: publisher.map{$0.count},
                                 equals: [ { value in value == 3 } ])
        result.cancellable.store(in: &cancellables)
        result1.cancellable.store(in: &cancellables)
        wait(for: [result.expectation, result1.expectation], timeout: 5)
    }

    func test_APIRepo_Error_404() {
        // arrange
        let error = NSError(domain: "404 Not Found", code: 404, userInfo: nil)
        // act
        stub(condition: isHost(stubURL)) { request in
            return OHHTTPStubs.HTTPStubsResponse(error: error)
        }
        let publisher: AnyPublisher<[MockItemDecodable], Error> = sut.request(.fake())

        // assert
        let result = expectFailure(of: publisher)
        result.cancellable.store(in: &cancellables)
        wait(for: [result.expectation], timeout: 1)
    }

    func test_APIRepo_Error_500() {
        // arrange
        let error = NSError(domain: "Internal Server Error", code: 500, userInfo: nil)
        // act
        stub(condition: isHost(stubURL)) { request in
            return OHHTTPStubs.HTTPStubsResponse(error: error)
        }
        let publisher: AnyPublisher<[MockItemDecodable], Error> = sut.request(.fake())

        // assert
        let result = expectFailure(of: publisher)
        result.cancellable.store(in: &cancellables)
        wait(for: [result.expectation], timeout: 1)
    }
}

public extension URL {
    static func fake (
        urlString: String = "https://www.url.com/"
    )  -> Self {
        URL(string: urlString)!
    }
}

private struct MockItemDecodable: Decodable {
    let id: Int
    let name: String
    let price: Double
    let description: String
}
