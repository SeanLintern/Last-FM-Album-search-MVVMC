//
//  AlbumListCoordinator.swift
//  LloydsLastFMTest
//
//  Created by Sean Lintern on 12/03/2019.
//  Copyright © 2019 Sean Lintern LTD. All rights reserved.
//

import UIKit

class AlbumListCoordinator: Coordinator {
    
    func start() {
        let controller = AlbumListViewController(delegate: self)
        navigationController.pushViewController(controller, animated: true)
    }
    
    fileprivate func fetchAlbumList(controller: AlbumListViewController, searchTerm: String) {
        controller.loadingStateUpdated(newState: .loading)
        
        LastFMAPI.fetchAlbums(searchTerm: searchTerm, success: { result in
            controller.loadingStateUpdated(newState: .loadingComplete)
            controller.update(viewModel: AlbumListViewModel(searchResult: result))
        }) { [weak self] in
            controller.loadingStateUpdated(newState: .loadingComplete)
            self?.showError()
        }
    }
    
    private func showError() {
        let alert = UIAlertController(title: nil, message: "An unexpected error occured, please try again soon.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        navigationController.present(alert, animated: true, completion: nil)
    }
}

extension AlbumListCoordinator: AlbumListViewControllerDelegate {
    func albumListDidSelectAlbum(controller: AlbumListViewController, album: LastFMAlbum) {
        let coordinator = AlbumDetailsCoordinator(navigationController: navigationController)
        addChild(coordinator: coordinator)
        coordinator.start(album: album)
    }
    
    func albumListDidSearch(controller: AlbumListViewController, searchTerm: String) {
        fetchAlbumList(controller: controller, searchTerm: searchTerm)
    }
}
