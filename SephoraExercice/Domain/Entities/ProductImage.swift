//
//  ProductImage.swift
//  Domain
//
//  Created by Firas on 28/09/2023.
//

import Foundation

public struct ProductImage: Codable, Hashable {
    
    public var small: String?
    public var large: String?

    init(small: String? = nil, large: String? = nil) {
        self.small = small
        self.large = large
    }
}
