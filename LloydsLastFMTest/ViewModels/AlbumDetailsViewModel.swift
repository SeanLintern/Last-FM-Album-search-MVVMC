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
    private static let trackTitleAttributes: [String: Any] = [NSFontAttributeName: UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium), NSKernAttributeName: 1.3, NSForegroundColorAttributeName: UIColor.black]
    private static let trackSubtitleAttributes: [String: Any] = [NSFontAttributeName: UIFont.systemFont(ofSize: 12, weight: UIFontWeightMedium), NSKernAttributeName: 1.0, NSForegroundColorAttributeName: UIColor.darkGray]

    var title: NSAttributedString {
        return NSAttributedString(string: album.name, attributes: AlbumDetailsViewModel.titleAttributes)
    }
    
    var subtitle: NSAttributedString {
        return NSAttributedString(string: album.artist, attributes: AlbumDetailsViewModel.subtitleAttributes)
    }
    
    var detailsHeader: NSAttributedString {
        return NSAttributedString(string: "DETAILS", attributes: AlbumDetailsViewModel.titleAttributes)
    }

    var trackHeader: NSAttributedString {
        return NSAttributedString(string: "TRACKS", attributes: AlbumDetailsViewModel.titleAttributes)
    }
    
    var wikiText: NSAttributedString? {
        if let data = album.wiki?.summary.data(using: .utf8) {
            return try? NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }
        return nil
    }
    
    var image: ImageResource? {
        return album.image.filter({$0.size == .mega}).first
    }
    
    var tracks: [LastFMTrack] {
        return album.tracks.track
    }
    
    var trackCount: Int {
        return tracks.count
    }

    var album: LastFMAlbumDetails
    
    init(album: LastFMAlbumDetails) {
        self.album = album
    }
    
    func trackTitle(at index: Int) -> NSAttributedString {
        return NSAttributedString(string: tracks[index].name, attributes: AlbumDetailsViewModel.trackTitleAttributes)
    }
    
    func trackSubtitle(at index: Int) -> NSAttributedString? {
        if let durationValue = Int(tracks[index].duration) {
            let mins = (durationValue % 3600) / 60
            let secs = (durationValue % 3600) % 60
            return NSAttributedString(string: "\(mins):\(secs)\(secs < 10 ? "0" : "")", attributes: AlbumDetailsViewModel.trackSubtitleAttributes)
        }
        return nil
    }
}
