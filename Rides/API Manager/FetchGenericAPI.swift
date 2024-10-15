//
//  FetchAPI.swift
//  Rides
//
//  Created by Mirold Dabre on 10/12/24.
//

import Foundation
import Combine

protocol Fetchable {
    func fetch<T>(with urlComponent: URLComponents, session: URLSession) -> AnyPublisher<T,APIErrors> where T: Decodable
}

extension Fetchable {
    func fetch<T>(with urlComponent: URLComponents, session: URLSession) -> AnyPublisher<T,APIErrors> where T: Decodable {
        guard let url = urlComponent.url else {
            return Fail(error: APIErrors.request(message: AppConstants.API.invalidURL)).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                APIErrors.network(message: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
    
    func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, APIErrors> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        return Just(data)
            .decode(type: T.self, decoder: decoder)
            .mapError { error in
                    .parsing(message: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
    
}
