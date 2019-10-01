//
//  PostsDetailView.swift
//  BabylonDemoApp
//
//  Created by Kyle Alan Hale on 7/7/19.
//  Copyright © 2019 Kyle Alan Hale. All rights reserved.
//

import SwiftUI

struct SongDetailView : View {
    var song: SongsListItem
    var color: Color
    
    var body: some View {
        ZStack {
            // Use post color to create a lighter-colored background
            color
                .opacity(0.1)
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(alignment: .leading) {
                    Text(song.title)
                        .font(.title)
                    Text("by \(song.artist)").font(.headline)
                    Text("track \(song.trackNumber) of \(song.album)").font(.headline)
                    HStack {
                        Spacer()
                        Image(systemName: "bolt.horizontal").padding()
                        Spacer()
                    }
                    ITunesImageView(url: song.albumArtworkURL)
                }
                .lineLimit(nil)
                .padding()
            }
        }
        .navigationBarTitle("Post", displayMode: .inline)
    }
}

