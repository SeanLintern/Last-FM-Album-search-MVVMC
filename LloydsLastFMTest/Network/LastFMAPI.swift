//
//  LastFMAPI.swift
//  LloydsLastFMTest
//
//  Created by Sean Lintern on 12/03/2019.
//  Copyright © 2019 Sean Lintern LTD. All rights reserved.
//

import UIKit

typealias LastFMAlbumSearchSuccess = ((_ result: LastFMAlbumSearchResult) -> Void)
typealias LastFMAlbumDetailsSuccess = ((_ result: LastFMAlbumSearchResult) -> Void)

typealias LastFMAlbumSearchFailure = (() -> Void)

fileprivate enum LastFMEndpoints {
    case albumSearch(searchTerm: String, apiKey: String)
    case albumDetails(mbid: String, apiKey: String)
    
    var path: String {
        switch self {
        case .albumSearch(let searchTerm, let apiKey):
            return "?method=album.search&album=\(searchTerm)&api_key=\(apiKey)&format=json"
        case .albumDetails(let mbid, let apiKey):
            return "?method=album.getinfo&mbid=\(mbid)&api_key=\(apiKey)&format=json"
        }
    }
}

struct LastFMAPI {

    private static let basePath = "http://ws.audioscrobbler.com/2.0/"
    private static let APIKey = "d054a40973b34868be34d7dd4fd2e363"
    
    static func fetchAlbums(searchTerm: String, success: LastFMAlbumSearchSuccess?, failure: LastFMAlbumSearchFailure?) {
        guard let url = URL(string: LastFMAPI.basePath + LastFMEndpoints.albumSearch(searchTerm: searchTerm, apiKey: LastFMAPI.APIKey).path) else {
            failure?()
            return
        }
        
        let request = NetworkManager.createRequest(url: url, additionalHeaders: nil, type: .get, body: nil)
        
        NetworkManager.performRequest(request: request, success: { (data, response) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    
                    let result = try decoder.decode([String: LastFMAlbumSearchResult].self, from: data)
                    
                    guard let searchResult = result["results"] else {
                        failure?()
                        return
                    }
                    
                    success?(searchResult)
                } catch {
                    print(error)
                    failure?()
                }
            } else {
                failure?()
            }
        }) { (type, code, description, data) in
            failure?()
        }
    }
    
    static func fetchAlbumDetails(mbid: String, success: LastFMAlbumDetailsSuccess?, failure: LastFMAlbumSearchFailure?) {
        guard let url = URL(string: LastFMAPI.basePath + LastFMEndpoints.albumDetails(mbid: mbid, apiKey: LastFMAPI.APIKey).path) else {
            failure?()
            return
        }
        
        let request = NetworkManager.createRequest(url: url, additionalHeaders: nil, type: .get, body: nil)
        
        NetworkManager.performRequest(request: request, success: { (data, response) in
            if let data = data {
                do {
                    print(try JSONSerialization.jsonObject(with: data, options: .allowFragments))
                } catch {
                    print(error)
                    failure?()
                }
            } else {
                failure?()
            }
        }) { (type, code, description, data) in
            failure?()
        }

    }
}
