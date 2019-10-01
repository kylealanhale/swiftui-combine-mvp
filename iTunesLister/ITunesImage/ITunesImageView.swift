//
//  ITunesImageView.swift
//  Poster Poster
//
//  Created by Kyle Alan Hale on 9/29/19.
//  Copyright © 2019 Kyle Alan Hale. All rights reserved.
//

import SwiftUI

struct ITunesImageView: View {
    @ObservedObject var presenter: ITunesImagePresenter
    var url: String
    
    init(url: String) {
        self.presenter = ITunesImagePresenter(withITunesImageURL: url, interactor: ProductionITunesImageInteractor())
        self.url = url
    }
    var body: some View {
        Group {
            if presenter.isLoaded {
                if presenter.hadError {
                    Image(systemName: "xmark.octagon.fill")
                        .resizable().aspectRatio(1, contentMode: .fit)
                        .frame(width: 100, height: 100, alignment: .center)
                }
                else {
                    Image(uiImage: UIImage(data: presenter.imageData) ?? UIImage(systemName: "xmark.octagon.fill") ?? UIImage())
                    .resizable().aspectRatio(contentMode: .fit)
                }
            }
            else {
                Image(systemName: "music.note")
                    .resizable().aspectRatio(1, contentMode: .fit)
                    .frame(width: 100, height: 100, alignment: .center)
            }
        }
        .frame(minWidth: .leastNormalMagnitude, idealWidth: CGFloat(presenter.width), maxWidth: .greatestFiniteMagnitude, minHeight: .leastNormalMagnitude, idealHeight: CGFloat(presenter.height), maxHeight: .greatestFiniteMagnitude, alignment: .top)

    }
}
