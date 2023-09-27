//
//  Network.swift
//  SephoraExercice
//
//  Created by Firas on 27/09/2023.
//

import Combine
import Foundation

protocol NetworkProtocol {
    func request<T: Decodable>(_ url: URL) -> AnyPublisher<[T], Error>
}

final class Network: NetworkProtocol{
    private let scheduler: DispatchQueue
    private var cancellable: AnyCancellable?

    init(
        scheduler: DispatchQueue = DispatchQueue(label: "API Queue", qos: .default, attributes: .concurrent)
    ) {
        self.scheduler = scheduler
    }

    func request<T: Decodable>(_ url: URL) -> AnyPublisher<[T], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
        .map { $0.data }
        .decode(type: [T].self, decoder: JSONDecoder())
       // .replaceError(with: [])
        .eraseToAnyPublisher()
    }
}
