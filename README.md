# SwiftUI & Combine MVP Demo App

I previously prototyped [an app](https://github.com/kylealanhale/swiftui-rxswift-mvp) that demoed how to transition an existing [RxSwift](https://github.com/ReactiveX/RxSwift) app to using [SwiftUI](https://developer.apple.com/documentation/swiftui) without refactoring all its RxSwift code. This app takes the next step: getting rid of any dependency on RxSwift and replacing it all with Apple's new [Combine](https://developer.apple.com/documentation/combine) framework.


## Setup

Requires Xcode 11 and iOS 13.

Open the iTunesLister project and launch the app. It will load a list of songs obtained via the [iTunes Search API](https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/iTuneSearchAPI/index.html).

## Features

* Song title list
* Song detail view with album artwork
* MVP architecture; see [the original prototype](https://github.com/kylealanhale/swiftui-rxswift-mvp) for a comprehensive writeup on its details
* Refactored reactive code using Combine instead of RxSwift
* `Service` layer using native `URLSession` and `Codable`
* HTTP caching of JSON and images for offline access
* URL image loader for iTunes images written entirely in SwiftUI
* Unit tests for dimension parsing of image loader
* Offline mode
	* If the app is launched for the first time while offline a "Retry" button will be shown
	* If the app has been launched before, the previous list will be shown

## To-dos
 
* Figure out how to do image rotation animations in SwiftUI (see comment in ITunesImageView)
* Install Catalina and write previews for all the SwiftUI views
