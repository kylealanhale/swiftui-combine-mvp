//
//  SongsModel.swift
//  BabylonDemoApp
//
//  Created by Kyle Alan Hale on 6/30/19.
//  Copyright © 2019 Kyle Alan Hale. All rights reserved.
//

import Foundation
import Combine

private struct ITunesSearchResult: Codable {
    var resultCount: Int
    var results: [ITunesTrack]
}

struct ITunesTrack: Codable {
    var trackId: Int
    var kind: String
    var artistName: String
    var collectionName: String
    var trackName: String
    var trackNumber: Int
    var releaseDate: String
    var primaryGenreName: String
    var artworkUrl100: String
    var previewUrl: String
    var trackViewUrl: String
}
protocol ITunesInteractor {
    func getMovies(matching searchString: String) -> AnyPublisher<[ITunesTrack], ServiceError>
}

final class ProductionITunesInteractor: ITunesInteractor, Service {
    private func getSearchResult(matching searchString: String) -> AnyPublisher<ITunesSearchResult, ServiceError> {
        return get(fromURL: searchString)
    }
    func getMovies(matching searchString: String) -> AnyPublisher<[ITunesTrack], ServiceError> {
        return getSearchResult(matching: searchString)
            .map { result in result.results }
            .eraseToAnyPublisher()
    }
}
