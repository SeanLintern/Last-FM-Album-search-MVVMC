//
//  AlbumListCoordinator.swift
//  LloydsLastFMTest
//
//  Created by Sean Lintern on 12/03/2019.
//  Copyright © 2019 Sean Lintern LTD. All rights reserved.
//

import Foundation

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
        }) {
            controller.loadingStateUpdated(newState: .loadingComplete)
        }
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
