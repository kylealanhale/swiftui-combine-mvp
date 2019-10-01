//
//  ITunesImagePresenter.swift
//  Poster Poster
//
//  Created by Kyle Alan Hale on 9/30/19.
//  Copyright © 2019 Kyle Alan Hale. All rights reserved.
//

import Foundation
import Combine

final class ITunesImagePresenter: ObservableObject {
    @Published var imageData = Data()
    @Published var width = 0
    @Published var height = 0
    @Published var isLoaded = false
    @Published var hadError = false

    private let urlString: String
    private let interactor: ITunesImageInteractor
    private var cancellable: AnyCancellable?

    init(withITunesImageURL urlString: String, interactor: ITunesImageInteractor) {
        self.urlString = urlString
        self.interactor = interactor
        extractDimensions()
        loadImage()
    }
    
    private func extractDimensions() {
        if let range = urlString.range(of: #"(\d+x\d+)bb.jpg"#, options: .regularExpression) {
            var dimensionsString = String(urlString[range])
            dimensionsString = dimensionsString.replacingOccurrences(of: "bb.jpg", with: "")
            let dimensions = dimensionsString.split(separator: "x")
            self.width = Int(dimensions[0]) ?? 0
            self.height = Int(dimensions[1]) ?? 0
        }
    }
    
    private func loadImage() {
        cancellable = interactor.getImage(fromURL: urlString)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .failure(let error):
                        self.isLoaded = true
                        self.hadError = true
                    case .finished:
                        self.isLoaded = true
                        self.hadError = false
                }
            }, receiveValue: { [weak self] data in
                self?.imageData = data
            })
    }
}
