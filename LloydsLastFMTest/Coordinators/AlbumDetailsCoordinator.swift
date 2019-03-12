//
//  AlbumDetailsCoordinator.swift
//  LloydsLastFMTest
//
//  Created by Sean Lintern on 12/03/2019.
//  Copyright © 2019 Sean Lintern LTD. All rights reserved.
//

import UIKit

class AlbumDetailsCoordinator: Coordinator {

    func start(album: LastFMAlbum) {
        let controller = AlbumDetailsViewController()
        navigationController.pushViewController(controller, animated: true)
        controller.navigationItem.title = album.name
        fetchAlbumDetails(for: album, on: controller)
    }
    
    private func fetchAlbumDetails(for album: LastFMAlbum, on controller: AlbumDetailsViewController) {
        controller.loadingStateUpdated(newState: .loading)
        
        LastFMAPI.fetchAlbumDetails(mbid: album.mbid, success: { (result) in
            
        }) {
            
        }
    }
}
