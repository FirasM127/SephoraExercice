//
//  ProductsUseCaseMock.swift
//  SephoraExerciceTests
//
//  Created by Firas on 28/09/2023.
//

@testable import SephoraExercice
import Combine
import Domain

public final class ProductsUseCaseMock: ProductsUseCaseProtocol {
    
    enum Call: Equatable {
        case fetchProducts
    }
    
    var calls: [Call] = []
    
    var getProductsReturnValue: Result<[Product], Error> =  .success([Product.fake(), Product.fake()])
    
    public func fetchProducts() -> AnyPublisher<[Product], Error> {
        
        calls.append(.fetchProducts)

        return getProductsReturnValue.publisher.eraseToAnyPublisher()
    }
}
