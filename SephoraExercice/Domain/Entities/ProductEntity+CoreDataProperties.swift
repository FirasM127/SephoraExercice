//
//  ProductEntity+CoreDataProperties.swift
//  Domain
//
//  Created by Firas on 28/09/2023.
//
//

import Foundation
import CoreData


extension ProductEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductEntity> {
        return NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var productDescription: String?
    @NSManaged public var price: Double
    @NSManaged public var image: String?
    @NSManaged public var isSpecialBrand: Bool
}

extension ProductEntity : Identifiable {

}
