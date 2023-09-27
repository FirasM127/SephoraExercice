//
//  AppNavigator.swift
//  SephoraExercice
//
//  Created by Firas on 27/09/2023.
//

import UIKit
import Domain
import Platform

protocol AppNavigatorType {
    func toMain()
}

struct AppNavigator: AppNavigatorType {
    let window: UIWindow
    
    func toMain() {
        let navController = UINavigationController()
        let useCaseProvider = Platform.ProductsUseCaseProvider()
        let viewModel = MainViewModel(useCaseProvider.makeProductsUseCase())
        
        let viewController = MainViewController(viewModel: viewModel)
        navController.viewControllers = [viewController]
        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
}
