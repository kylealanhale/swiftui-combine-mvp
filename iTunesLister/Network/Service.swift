//
//  Service.swift
//  iTunesLister
//
//  Created by Kyle Alan Hale on 9/30/19.
//  Copyright © 2019 Kyle Alan Hale. All rights reserved.
//

import Foundation
import Combine

enum ServiceError: Error {
    case url(URLError?)
    case decode
    case unknown(Error)
}

protocol Service {
    func get<T: Codable>(fromURL urlString: String) -> AnyPublisher<T, ServiceError>
    func getData(fromURL url: String) -> AnyPublisher<Data, ServiceError>
}
extension Service {
    func get<T: Codable>(fromURL urlString: String) -> AnyPublisher<T, ServiceError> {
        return getData(fromURL: urlString)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in .decode }
            .eraseToAnyPublisher()
    }
    func getData(fromURL url: String) -> AnyPublisher<Data, ServiceError> {
        guard let url = URL(string: url) else {
            return Fail<Data, ServiceError>(error: .url(URLError(URLError.Code.badURL))).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.cachePolicy = URLRequest.CachePolicy.returnCacheDataElseLoad // Use cache for temporary persistence
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map { $0.data }
            .mapError { error in .url(error) }
            .eraseToAnyPublisher()
    }
}
