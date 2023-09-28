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
    public var image: ProductImage?

    
    enum CodingKeys: String, CodingKey {
        case id = "product_id"
        case name = "product_name"
        case image = "images_url"
        case description = "description"
        case price = "price"
        case isSpecialBrand = "is_special_brand"
    }

    public init(id: Int?,
                name: String?,
                description: String?,
                price: Double?,
                isSpecialBrand: Bool?,
                image: ProductImage?){
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.image = image
        self.isSpecialBrand = isSpecialBrand
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try? container.decode(Int.self, forKey: .id)
        name = try? container.decode(String.self, forKey: .name)
        description = try? container.decode(String.self, forKey: .description)
        price = try? container.decode(Double.self, forKey: .price)
        isSpecialBrand = try? container.decode(Bool.self, forKey: .isSpecialBrand)
        image = try? container.decode(ProductImage.self, forKey: .image)
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
        isSpecialBrand: Bool = true,
        image: ProductImage 
    ) -> Self {
        .init(id: id,
              name: name,
              description: description,
              price: price,
              isSpecialBrand: isSpecialBrand,
              image: image)
    }
}
