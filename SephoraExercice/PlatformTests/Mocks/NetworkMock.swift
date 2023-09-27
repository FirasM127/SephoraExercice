//
//  NetworkMock.swift
//  PlatformTests
//
//  Created by Firas on 27/09/2023.
//

@testable import Platform
import Combine

class NetworkMock: NetworkProtocol{
    enum Call: Equatable {
        case request(url: URL)
    }
    
    var calls: [Call] = []
    
    func request<T>(_ url: URL) -> AnyPublisher<[T], Error> where T : Decodable {
        calls.append(.request(url: url))
        return Empty().eraseToAnyPublisher()
    }
}
