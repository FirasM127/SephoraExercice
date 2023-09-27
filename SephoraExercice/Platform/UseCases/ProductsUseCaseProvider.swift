//
//  ProductsUseCaseProvider.swift
//  Platform
//
//  Created by Firas on 27/09/2023.
//

import Domain

public final class ProductsUseCaseProvider: UseCaseProviderProtocol {

    private let network: Network
    
    public init() {
        network = Network()
    }
    
    public func makeProductsUseCase() -> ProductsUseCaseProtocol {
        return ProductsUseCase(network: network)
    }
}
