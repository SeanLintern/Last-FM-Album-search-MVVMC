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
        let controller = AlbumDetailsViewController(viewModel: AlbumDetailsViewModel(album: album))
        navigationController.pushViewController(controller, animated: true)
    }
}
