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
        fetchAlbumList(controller: controller)
    }
    
    private func fetchAlbumList(controller: AlbumListViewController) {
        controller.loadingStateUpdated(newState: .loading)
        
        LastFMAPI.fetchAlbums(searchTerm: "Parachutes", success: { result in
            controller.loadingStateUpdated(newState: .loadingComplete)
            controller.update(viewModel: AlbumListViewModel(searchResult: result))
        }) {
            controller.loadingStateUpdated(newState: .loadingComplete)
        }
    }
}

extension AlbumListCoordinator: AlbumListViewControllerDelegate {
    
}
