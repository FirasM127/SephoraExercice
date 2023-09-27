//
//  Product.swift
//  Domain
//
//  Created by Firas on 27/09/2023.
//

public struct Product: Codable, Hashable {
    public var id: Int?
    public var name: String?
    public var description: String?
    public var price: Double?
    public var isSpecialBrand: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "product_id"
        case name = "product_name"
        case isSpecialBrand = "is_special_brand"
    }

    public init(id: Int?,
                name: String?,
                description: String?,
                price: Double?,
                isSpecialBrand: Bool?){
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.isSpecialBrand = isSpecialBrand
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try? container.decode(Int.self, forKey: .id)
        name = try? container.decode(String.self, forKey: .name)
        isSpecialBrand = try? container.decode(Bool.self, forKey: .isSpecialBrand)
    }
}

extension Product: Equatable {
    public static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}

public extension Product {
    static func fake (
        id: Int = 12345678,
        name: String = "Channel sensation",
        description: String = "fakeDescription",
        price: Double = 100,
        isSpecialBrand: Bool = true

    ) -> Self {
        .init(id: id,
              name: name,
              description: description,
              price: price,
              isSpecialBrand: isSpecialBrand)
    }
}
