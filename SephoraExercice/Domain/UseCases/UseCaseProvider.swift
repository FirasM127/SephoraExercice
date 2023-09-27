//
//  UseCaseProvider.swift
//  SephoraExercice
//
//  Created by Firas on 27/09/2023.
//

import Foundation
///Defines all the use cases that the UseCaseProvider should provide
///
///
public protocol UseCaseProviderProtocol {
    func makeProductsUseCase() -> ProductsUseCaseProtocol
}
