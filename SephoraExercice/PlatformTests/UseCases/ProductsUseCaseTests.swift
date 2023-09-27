//
//  ProductsUseCaseTests.swift
//  PlatformTests
//
//  Created by Firas on 27/09/2023.
//

@testable import Domain
@testable import Platform
import XCTest

final class ProductsUseCaseTests: XCTestCase {
    private var sut: ProductsUseCase!
    private var mockNetwork = NetworkMock()
    
    override func setUp() {
        super.setUp()
        sut = .init(network: mockNetwork)
    }
    
    func test_getTeamsList() {
        //act
        let _ = sut.fetchProducts()
        
        // assert
        XCTAssertEqual(
            mockNetwork.calls,
            [
                .request(
                    url: .fake(
                        urlString: "https://www.sephora.com"
                    )
                )
            ]
        )
    }
}
