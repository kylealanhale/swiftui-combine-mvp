//
//  PostsPresenter.swift
//  BabylonDemoApp
//
//  Created by Kyle Alan Hale on 6/30/19.
//  Copyright © 2019 Kyle Alan Hale. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct SongsListItem {
    var id: Int
    var title: String
    var artist: String
    var album: String
    var trackNumber: Int
    var releaseDate: String
    var genre: String
    var albumArtworkURL: String
}

protocol SongsPresenter {
    init(interactor: ITunesInteractor)
    var items: [SongsListItem] { get }
    var isOffline: Bool { get }
}

final class ProductionSongsPresenter: SongsPresenter, ObservableObject {
    @Published var items: [SongsListItem] = []
    @Published var isOffline: Bool = false
    
    private let interactor: ITunesInteractor
    
    init(interactor: ITunesInteractor) {
        self.interactor = interactor
        self.populate()
    }
    
    // Populate list of items from iTunes track model data and let SwiftUI view know about it
    internal func populate() {
        cancellable = interactor
            // Could later be a search string tied to a text field
            .getSongs(matching: "The Smashing Pumpkins")
            .receive(on: RunLoop.main)
            .map { tracks in tracks.map { track in
                SongsListItem(
                    id: track.trackId,
                    title: track.trackName,
                    artist: track.artistName,
                    album: track.collectionName,
                    trackNumber: track.trackNumber,
                    releaseDate: track.releaseDate,
                    genre: track.primaryGenreName,
                    albumArtworkURL: track.artworkUrl100
                )
            }}
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                    case .failure(let error):
                        self?.isOffline = true
                        print(error, "Failed for some reason.")  // Ideally this would be logged to a server
                    case .finished:
                        self?.isOffline = false
                }
            }, receiveValue: { [weak self] songs in
                self?.items = songs
            })
    }
    private var cancellable: AnyCancellable?
}
