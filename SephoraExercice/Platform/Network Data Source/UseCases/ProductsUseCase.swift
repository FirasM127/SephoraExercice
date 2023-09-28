//
//  ProductsUseCase.swift
//  SephoraExercice
//
//  Created by Firas on 27/09/2023.
//

import Domain
import Combine

final class ProductsUseCase: ProductsUseCaseProtocol {
    private let network: NetworkProtocol
    
    init(network: NetworkProtocol) {
        self.network = network
    }

    func fetchProducts() -> AnyPublisher<[Product], Error> {
        do{
            return try network.request(ApiRouter.getProducts.asURL())
        }catch let error{
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
