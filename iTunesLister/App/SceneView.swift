//
//  SceneView.swift
//  BabylonDemoApp
//
//  Created by Kyle Alan Hale on 6/27/19.
//  Copyright © 2019 Kyle Alan Hale. All rights reserved.
//

import SwiftUI

struct SceneView: View {
    var body: some View {
        NavigationView {
            /// Instantiating and doing dependency injection here in a top-level
            /// view; ostensibly this SongsView could be inserted anywhere in the
            /// view hierarchy.
            SongsView(presenter: ProductionSongsPresenter(interactor: ProductionITunesInteractor()))
        }
    }
}
