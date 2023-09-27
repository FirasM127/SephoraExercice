//
//  ProductViewModel.swift
//  SephoraExercice
//
//  Created by Firas on 28/09/2023.
//

import Foundation
import Domain

struct ProductViewModel: Hashable {

    // MARK: - Properties
    private let product: Product

    // MARK: - Initializer
    init(_ product: Product) {
        self.product = product
    }
}

extension ProductViewModel {
    // MARK: - Get Only Properties
    var id: Int { return product.id ?? 0 }

    var name: String { return product.name  ?? "" }
}