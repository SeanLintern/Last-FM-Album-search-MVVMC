//
//  LastFMAPI.swift
//  LloydsLastFMTest
//
//  Created by Sean Lintern on 12/03/2019.
//  Copyright © 2019 Sean Lintern LTD. All rights reserved.
//

import UIKit

typealias LastFMAlbumSearchSuccess = (() -> Void)
typealias LastFMAlbumSearchFailure = (() -> Void)

fileprivate enum LastFMEndpoints {
    case albumSearch
    
    var path: String {
        switch self {
        case .albumSearch:
            return "show/album.search"
        }
    }
}

struct LastFMAPI {

    private static let basePath = "https://www.last.fm/api"
    
    static func fetchAlbums(success: LastFMAlbumSearchSuccess?, failure: LastFMAlbumSearchFailure?) {
        guard let url = URL(string: LastFMAPI.basePath + LastFMEndpoints.albumSearch.path) else {
            failure?()
            return
        }
        
        let request = NetworkManager.createRequest(url: url, additionalHeaders: nil, type: .get, body: nil)
        
        NetworkManager.performRequest(request: request, success: { (data, response) in
            success?()
        }) { (type, code, description, data) in
            failure?()
        }
    }
}
