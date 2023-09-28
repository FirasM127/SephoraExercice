//
//  CoreDataHelper.swift
//  SephoraExercice
//
//  Created by Firas on 28/09/2023.
//

import Foundation
import CoreData
import Domain

class CoreDataHelper {
    static let shared = CoreDataHelper()

    // The persistent container for the application
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AppDataModel") // Change to your data model name
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    private init() {} // Prevent external instantiation

    // MARK: - Core Data Saving Support

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    // MARK: - Product Operations

    func saveProduct(product: Product) {
        let context = CoreDataHelper.shared.persistentContainer.viewContext
        let productEntity = ProductEntity(context: context)
        productEntity.name = product.name
        productEntity.productDescription = product.description
        productEntity.price = product.price ?? 0.0
        productEntity.isSpecialBrand = product.isSpecialBrand ?? false
        productEntity.image = product.image?.small

        CoreDataHelper.shared.saveContext()
    }

    func getAllProducts() -> [Product] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()

        do {
            let productEntities = try context.fetch(fetchRequest)
            let products = productEntities.map { mapToProduct(productEntity: $0) }
            
            return products
        } catch {
            print("Error fetching products: \(error)")
            return []
        }
    }
    
    func mapToProduct(productEntity: ProductEntity) -> Product {
        return Product(
            id: productEntity.id,
            name: productEntity.name,
            description: productEntity.productDescription,
            price: productEntity.price,
            isSpecialBrand: productEntity.isSpecialBrand,
            image: ProductImage(small: productEntity.image)
        )
    }

}
