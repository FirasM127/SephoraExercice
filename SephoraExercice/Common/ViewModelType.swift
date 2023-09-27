//
//  ViewModelType.swift
//  SephoraExercice
//
//  Created by Firas on 27/09/2023.
//

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input, cancelBag: CancelBag) -> Output
}
