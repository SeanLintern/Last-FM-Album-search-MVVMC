//
//  AlbumListViewModel.swift
//  LloydsLastFMTest
//
//  Created by Sean Lintern on 12/03/2019.
//  Copyright © 2019 Sean Lintern LTD. All rights reserved.
//

import UIKit

struct AlbumListViewModel {
    
    private static let titleAttributes: [String: Any] = [NSFontAttributeName: UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium), NSKernAttributeName: 1.5, NSForegroundColorAttributeName: UIColor.black]
    private static let subtitleAttributes: [String: Any] = [NSFontAttributeName: UIFont.systemFont(ofSize: 12, weight: UIFontWeightMedium), NSKernAttributeName: 1, NSForegroundColorAttributeName: UIColor.darkGray]

    private var searchResult: LastFMAlbumSearchResult
    
    var numberOfItems: Int {
        return searchResult.albummatches.albums.count
    }
    
    init(searchResult: LastFMAlbumSearchResult) {
        self.searchResult = searchResult
    }
    
    func title(for indexPath: IndexPath) -> NSAttributedString {
        return NSAttributedString(string: searchResult.albummatches.albums[indexPath.row].name, attributes: AlbumListViewModel.titleAttributes)
    }
    
    func subtitle(for indexPath: IndexPath) -> NSAttributedString {
        return NSAttributedString(string: searchResult.albummatches.albums[indexPath.row].artist, attributes: AlbumListViewModel.subtitleAttributes)
    }
    
    /// Attempts to return a valid image resource of small size
    ///
    /// - Parameter indexPath: IndexPath representing the data point
    /// - Returns: A potential ImageResource of small size
    func imageResource(for indexPath: IndexPath) -> ImageResource? {
        return searchResult.albummatches.albums[indexPath.row].image.first(where: {$0.size == .small && $0.text.count > 0})
    }
}
