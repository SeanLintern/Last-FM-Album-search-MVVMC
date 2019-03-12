//
//  AlbumListTest.swift
//  LloydsLastFMTestTests
//
//  Created by Sean Lintern on 12/03/2019.
//  Copyright © 2019 Sean Lintern LTD. All rights reserved.
//

import XCTest
@testable import LloydsLastFMTest

class AlbumListTest: XCTestCase {
    private var albumListViewModel: AlbumListViewModel!
    
    override func setUp() {
        let path = Bundle(for: AlbumDetailsViewModelTest.self).url(forResource: "albumListTestJson", withExtension: "json")
        
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
            let result = try decoder.decode([String: LastFMAlbumSearchResult].self, from: jsonData)
            
            guard let searchResult = result["results"] else {
                XCTFail("Failed to find testing JSON response file.")
                return
            }

            self.albumListViewModel = AlbumListViewModel(searchResult: searchResult)
            
            super.setUp()
        } catch {
            XCTFail("Failed to find testing JSON response file.")
        }
    }

    func testDisplayValues() {
        let testAlbum = albumListViewModel.searchResult.albummatches.albums.first!
        let testIndexPath = IndexPath(row: 0, section: 0)
        
        XCTAssert(testAlbum.artist == albumListViewModel.album(for: testIndexPath).artist)
        XCTAssert(testAlbum.name == albumListViewModel.album(for: testIndexPath).name)
        XCTAssert(testAlbum.name == albumListViewModel.title(for: testIndexPath).string)
        XCTAssert(testAlbum.artist == albumListViewModel.subtitle(for: testIndexPath).string)
        XCTAssert(albumListViewModel.searchResult.albummatches.albums.count == albumListViewModel.numberOfItems)
        XCTAssert(testAlbum.image.first(where: {$0.size == .small && $0.text.count > 0})?.resourceURL == albumListViewModel.imageResource(for: testIndexPath)?.resourceURL)
    }
}
