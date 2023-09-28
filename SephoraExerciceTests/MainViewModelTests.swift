//
//  MainViewModel.swift
//  SephoraExerciceTests
//
//  Created by Firas on 28/09/2023.
//

@testable import SephoraExercice
import XCTest
import Combine
import Domain

final class MainViewModelTests: XCTestCase {

    private var sut: MainViewModel!
    private var mockProductsUseCase: ProductsUseCaseMock!
    
    private var input: PassthroughSubject<MainViewModel.Input, Never> = .init()
    private var output: AnyPublisher<MainViewModel.Output, Never>!
    
    private var cancelBag: CancelBag!

    override func setUp() {
        mockProductsUseCase = ProductsUseCaseMock()
        sut = MainViewModel(mockProductsUseCase)
        cancelBag = CancelBag()
        output = sut.transform(input: input.eraseToAnyPublisher())
    }

    func test_onLoad_fetch_data_from_DataBase() {
        // arrange
        mockProductsUseCase.calls.removeAll()
        
        // act
        input.send(.load)
        
        // assert
        wait {
            XCTAssertEqual(CoreDataHelper.shared.getAllProducts().count, 2)
            XCTAssertEqual(self.mockProductsUseCase.calls, [])
        }
    }
    
    func test_onLoad_fetch_data_from_API() {
        // arrange
        mockProductsUseCase.calls.removeAll()
        CoreDataHelper.shared.removeAllProductData()
        // act
        input.send(.load)
        
        // assert
        wait {
            XCTAssertEqual(self.mockProductsUseCase.calls, [.fetchProducts])
        }
    }
}
