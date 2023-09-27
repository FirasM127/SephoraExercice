//
//  ProductsUseCaseProtocol.swift
//  SephoraExercice
//
//  Created by Firas on 27/09/2023.
//

import Combine

public protocol ProductsUseCaseProtocol {
    func fetchProducts() -> AnyPublisher<[Product], Error>
}
