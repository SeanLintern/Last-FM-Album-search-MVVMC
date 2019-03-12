//
//  AppCoordinator.swift
//  LloydsLastFMTest
//
//  Created by Sean Lintern on 12/03/2019.
//  Copyright © 2019 Sean Lintern LTD. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    init(launchOptions: [UIApplication.LaunchOptionsKey: Any]?, navigationController: UINavigationController) {
        super.init(navigationController: navigationController)

        determineApplicationLaunchFlow()
    }
    
    private func determineApplicationLaunchFlow() {
        let coordinator = AlbumListCoordinator(navigationController: navigationController)
        addChild(coordinator: coordinator)
        coordinator.start()
    }
}
