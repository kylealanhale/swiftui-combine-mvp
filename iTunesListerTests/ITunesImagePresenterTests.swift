//
//  ITunesImagePresenterTests.swift
//  Poster PosterTests
//
//  Created by Kyle Alan Hale on 9/29/19.
//  Copyright © 2019 Kyle Alan Hale. All rights reserved.
//

import XCTest
@testable import iTunesLister

class ITunesImagePresenterTests: XCTestCase {
    func testDimensions() {
        let presenter = ITunesImagePresenter(withITunesImageURL: "https://is3-ssl.mzstatic.com/image/thumb/Music128/v4/95/f5/6e/95f56eee-f4a2-04b6-2a2c-7dadb620dfc8/source/100x100bb.jpg", interactor: ProductionITunesImageInteractor())
        
        let expectedWidth = 100
        let actualWidth = presenter.width
        XCTAssertEqual(expectedWidth, actualWidth)
        
        let expectedHeight = 100
        let actualHeight = presenter.height
        XCTAssertEqual(expectedHeight, actualHeight)
    }
    func testMissingDimensions() {
        let presenter = ITunesImagePresenter(withITunesImageURL: "https://is3-ssl.mzstatic.com/", interactor: ProductionITunesImageInteractor())
        
        let expectedWidth = 0
        let actualWidth = presenter.width
        XCTAssertEqual(expectedWidth, actualWidth)
        
        let expectedHeight = 0
        let actualHeight = presenter.height
        XCTAssertEqual(expectedHeight, actualHeight)
    }
}
