//
//  ITunesImageModel.swift
//  Poster Poster
//
//  Created by Kyle Alan Hale on 9/30/19.
//  Copyright © 2019 Kyle Alan Hale. All rights reserved.
//

import Foundation
import Combine

protocol ITunesImageInteractor {
    func getImage(fromURL urlString: String) -> AnyPublisher<Data, ServiceError>
}
final class ProductionITunesImageInteractor: ITunesImageInteractor, Service {
    func getImage(fromURL urlString: String) -> AnyPublisher<Data, ServiceError> {
        return getData(fromURL: urlString)
    }
}
