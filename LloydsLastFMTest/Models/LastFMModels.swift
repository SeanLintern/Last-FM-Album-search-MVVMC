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
