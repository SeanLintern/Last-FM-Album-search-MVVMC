//
//  AlbumDetailsViewModel.swift
//  LloydsLastFMTest
//
//  Created by Sean Lintern on 12/03/2019.
//  Copyright © 2019 Sean Lintern LTD. All rights reserved.
//

import UIKit

struct AlbumDetailsViewModel {
    
    private static let titleAttributes: [String: Any] = [NSFontAttributeName: UIFont.systemFont(ofSize: 18, weight: UIFontWeightMedium), NSKernAttributeName: 2.0, NSForegroundColorAttributeName: UIColor.black]
    private static let subtitleAttributes: [String: Any] = [NSFontAttributeName: UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium), NSKernAttributeName: 1.3, NSForegroundColorAttributeName: UIColor.darkGray]
    
    var title: NSAttributedString {
        return NSAttributedString(string: album.name, attributes: AlbumDetailsViewModel.titleAttributes)
    }
    
    var subtitle: NSAttributedString {
        return NSAttributedString(string: album.artist, attributes: AlbumDetailsViewModel.subtitleAttributes)
    }
    
    var image: ImageResource? {
        return album.image.filter({$0.size == .large}).first
    }

    private var album: LastFMAlbum
    
    init(album: LastFMAlbum) {
        self.album = album
    }
}
