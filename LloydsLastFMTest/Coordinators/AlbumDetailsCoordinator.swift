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
            controller.loadingStateUpdated(newState: .loadingComplete)
            controller.updateUI(viewModel: AlbumDetailsViewModel(album: result))
        }) { [weak self] in
            self?.showErrorAndPop()
        }
    }
    
    private func showErrorAndPop() {
        let alert = UIAlertController(title: nil, message: "An unexpected error occured, please try again soon.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { [weak self] (_) in
            self?.navigationController.popViewController(animated: true)
        }
        alert.addAction(ok)
        navigationController.present(alert, animated: true, completion: nil)
    }
}
