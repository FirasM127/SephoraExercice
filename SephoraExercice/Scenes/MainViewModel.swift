//
//  MainViewModel.swift
//  SephoraExercice
//
//  Created by Firas on 27/09/2023.
//

import Combine
import Foundation
import Domain

class MainViewModel {
    
    // MARK: - Properties
    private var products: [Product]?
    private var subscriptions = Set<AnyCancellable>()
    private let productsUseCase: ProductsUseCaseProtocol
    private let output: PassthroughSubject<Output, Never> = .init()

    // MARK: - Enumerations
    enum Input: Equatable {
        case load
        case refresh
    }

    enum Output {
        case fetchProductsDidFinish
        case fetchProductsDidFail(error: Error)
        case fetchProductsDidSuccess(products: [ProductViewModel])
    }

    
    // MARK: - Initializer
    init(_ productsUseCases: ProductsUseCaseProtocol) {
        self.productsUseCase = productsUseCases
    }
}

extension MainViewModel {
    // MARK: - User Defined Methods
        internal func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never> {
        input.sink { [weak self] event in
            switch event {
            case .load, .refresh:
                self?.requestProducts()
            }
        }.store(in: &subscriptions)
        return output.eraseToAnyPublisher()
    }
}

extension MainViewModel {
    // MARK: - API Requests
    
    private func requestProducts() {
        let valueHandler: ([Product]) -> Void = { [weak self] products in
            self?.products = products
            self?.output.send(.fetchProductsDidSuccess(products: products.map(ProductViewModel.init).sortArray()))
        }

        let completionHandler: (Subscribers.Completion<Error>) -> Void = { [weak self] completion in
            switch completion {
            case .failure(let error):
                self?.output.send(.fetchProductsDidFail(error: error))
            case .finished:
                self?.output.send(.fetchProductsDidFinish)
            }
        }

        productsUseCase.fetchProducts()
            .sink(receiveCompletion: completionHandler, receiveValue: valueHandler)
            .store(in: &subscriptions)
    }
}

private extension Array where Element == ProductViewModel {
    
     func sortArray() -> Self {
        let sortedArray = sorted { (obj1, obj2) -> Bool in
            return obj1.isSpecialBrand && !obj2.isSpecialBrand
        }
        
        return sortedArray
    }
}
