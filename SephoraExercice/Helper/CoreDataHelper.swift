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
    
    let AppModelName = "AppDataModel"
    let AppModelExtension = "momd"
    let platformModuleIdentifier = "firas.mili.Platform"

    // The persistent container for the application
    lazy var persistentContainer: NSPersistentContainer = {
        guard let frameworkBundle = Bundle(identifier: platformModuleIdentifier) else {
            fatalError("Failed to load the framework bundle.")
        }
        
        let modelURL = frameworkBundle.url(forResource: AppModelName, withExtension: AppModelExtension)!
        let managedObjectModel =  NSManagedObjectModel(contentsOf: modelURL)
        let container = NSPersistentContainer(name: AppModelName, managedObjectModel: managedObjectModel!)
        
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
        let productEntity = Domain.ProductEntity(context: context)
        productEntity.id = product.id
        productEntity.name = product.name
        productEntity.productDescription = product.description
        productEntity.price = product.price ?? 0.0
        productEntity.isSpecialBrand = product.isSpecialBrand ?? false
        productEntity.image = product.image?.small

        CoreDataHelper.shared.saveContext()
    }

    func getAllProducts() -> [Product] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Domain.ProductEntity> = Domain.ProductEntity.fetchRequest()

        do {
            let productEntities = try context.fetch(fetchRequest) as [AnyObject]
            var products = [Product]()
            for productEntity in productEntities {
                products.append(Product(
                    id: productEntity.id,
                    name: productEntity.name,
                    description: productEntity.productDescription,
                    price: productEntity.price,
                    isSpecialBrand: productEntity.isSpecialBrand,
                    image: ProductImage(small: productEntity.image)
                ))
            }

            return products
        } catch {
            print("Error fetching products: \(error)")
            return []
        }
    }
}
