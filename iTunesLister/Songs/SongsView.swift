//
//  PostsView.swift
//  BabylonDemoApp
//
//  Created by Kyle Alan Hale on 7/7/19.
//  Copyright © 2019 Kyle Alan Hale. All rights reserved.
//

import SwiftUI

struct SongsView : View {
    @ObservedObject var presenter: ProductionSongsPresenter
    
    var body: some View {
        List(presenter
                .items
                .map { ($0, Color.getRandom()) },  // Associate a random icon/background color with each post
            id: \.0.id  // Identify each post's list item by its ID
        ) { (song, color) in
            NavigationLink(destination: SongDetailView(song: song, color: color)) {
                HStack {
                    Image(systemName: "bolt.horizontal.fill").foregroundColor(color)
                    Text(song.title)
                }
            }
        }
            .navigationBarTitle(Text("Posts"))
            // Show retry button when offline
            .navigationBarItems(trailing: presenter.isOffline ? Button(action: presenter.populate) { HStack {
                Image(systemName: "bolt")
                Text("Retry")
            } }.foregroundColor(.red) : nil)
    }
}

fileprivate extension Color {
    /// Get a random color with saturation set to 1/3 and brightness to 2/3
    static func getRandom() -> Color {
        return Color(hue: .random(in: 0...1), saturation: 0.333, brightness: 0.666)
    }
}
