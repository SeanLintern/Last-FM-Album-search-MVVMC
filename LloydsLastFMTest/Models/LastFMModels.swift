//
//  Album.swift
//  LloydsLastFMTest
//
//  Created by Sean Lintern on 12/03/2019.
//  Copyright © 2019 Sean Lintern LTD. All rights reserved.
//

import Foundation

enum LastFMImageSize: String, Codable {
    case small
    case medium
    case large
    case extralarge
    case mega
    case unknown = ""
}

struct LastFMImage: Codable {
    let text: String
    let size: LastFMImageSize
    
    enum CodingKeys: String, CodingKey {
        case text = "#text"
        case size
    }
}

struct LastFMAlbum: Codable {
    let name: String
    let artist: String
    let url: URL
    let image: [LastFMImage]
    let streamable: String
    let mbid: String
}

struct LastFMAlbumSearchResult: Codable {
    let albummatches: LastFMAlbumMatches
}

struct LastFMAlbumMatches: Codable {
    enum CodingKeys: String, CodingKey {
        case albums = "album"
    }
    let albums: [LastFMAlbum]
}

struct LastFMAlbumDetails: Codable {
    let name: String
    let artist: String
    let url: URL
    let image: [LastFMImage]
    let mbid: String
    let listeners: String
    let playcount: String
    let tracks: LastFMTrackDetails
    let tags: LastFMTagDetails
    let wiki: LastFMWikiDetails
}

struct LastFMTrackDetails: Codable {
    let track: [LastFMTrack]
}

struct LastFMTrack: Codable {
    let name: String
    let url: URL
    let duration: String
}

struct LastFMTagDetails: Codable {
    let tag: [LastFMTag]
}

struct LastFMTag: Codable {
    let name: String
    let url: URL
}

struct LastFMWikiDetails: Codable {
    let published: String
    let summary: String
    let content: String
}
