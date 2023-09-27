//
//  ProductTests.swift
//  DomainTests
//
//  Created by Firas on 27/09/2023.
//

@testable import Domain
import XCTest

final class ProductTests: XCTestCase {

    func test_mapping() {
        //arrange
        let jsonDict: [String: Any?] = [
            "product_id": 12345678,
            "product_name": "Mascara Volume Extra Large Immédiat",
            "description": "Craquez pour le Mascara Size Up de Sephora Collection",
            "price": 140,
            "images_url":[
                "small": "https://dev.sephora.fr/10927_V2.jpg",
                "large": ""
            ],
            "c_brand":[
                "id": "SEPHO",
                "name": "SEPHORA COLLECTION"
            ],
            "is_productSet": false,
            "is_special_brand": false
        ]

        //act
        let data = try! JSONSerialization.data(withJSONObject: jsonDict)
        let product = try? JSONDecoder().decode(Product.self, from: data)

        //assert
        XCTAssertNotNil(product)
        XCTAssertEqual(product?.id, jsonDict["product_id"] as? Int)
        XCTAssertEqual(product?.name, jsonDict["product_name"] as? String)
        XCTAssertEqual(product?.price, jsonDict["price"] as? Double)
        XCTAssertEqual(product?.description, jsonDict["description"] as? String)
    }
}
