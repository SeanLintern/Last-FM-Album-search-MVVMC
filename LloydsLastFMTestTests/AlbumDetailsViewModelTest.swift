//
//  AlbumDetailsViewModelTest.swift
//  LloydsLastFMTestTests
//
//  Created by Sean Lintern on 12/03/2019.
//  Copyright © 2019 Sean Lintern LTD. All rights reserved.
//

import XCTest
@testable import LloydsLastFMTest

class AlbumDetailsViewModelTest: XCTestCase {
    
    private var detailsViewModel: AlbumDetailsViewModel!
    
    override func setUp() {
        let path = Bundle(for: AlbumDetailsViewModelTest.self).url(forResource: "albumDetailsTestJson", withExtension: "json")
        
        guard let jsonPath = path else {
            XCTFail("Failed to find build file path.")
            return
        }
        
        guard let jsonData = try? Data(contentsOf: jsonPath) else {
            XCTFail("Failed to find testing JSON response file.")
            return
        }
        
        let decoder = JSONDecoder()
        
        do {
            let result = try decoder.decode([String: LastFMAlbumDetails].self, from: jsonData)
            
            guard let albumResult = result["album"] else {
                XCTFail("Failed to find testing JSON response file.")
                return
            }
            
            self.detailsViewModel = AlbumDetailsViewModel(album: albumResult)
            
            super.setUp()
        } catch {
            XCTFail("Failed to find testing JSON response file.")
        }
    }
    
    func testAlbumDisplayStrings() {
        XCTAssert(detailsViewModel.title.string == detailsViewModel.album.name)
        XCTAssert(detailsViewModel.subtitle.string == detailsViewModel.album.artist)
        XCTAssert(detailsViewModel.image?.resourceURL == detailsViewModel.album.image.filter({$0.size == .mega}).first!.resourceURL)
        XCTAssertNotNil(detailsViewModel.image)
        XCTAssertNotNil(detailsViewModel.wikiText)
        XCTAssert(detailsViewModel.trackHeader.string == "TRACKS")
        XCTAssert(detailsViewModel.detailsHeader.string == "DETAILS")
        XCTAssert(detailsViewModel.trackCount == detailsViewModel.tracks.count)
        
        let testTrack = detailsViewModel.tracks[0]
        XCTAssert(detailsViewModel.trackTitle(at: 0).string == testTrack.name)
        
        if let durationValue = Int(testTrack.duration) {
            let mins = (durationValue % 3600) / 60
            let secs = (durationValue % 3600) % 60
            XCTAssert(detailsViewModel.trackSubtitle(at: 0)?.string == "\(mins):\(secs)\(secs < 10 ? "0" : "")")
        } else {
            XCTFail()
        }
    }
}
