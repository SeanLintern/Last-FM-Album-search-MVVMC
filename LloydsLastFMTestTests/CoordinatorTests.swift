//
//  CoordinatorTests.swift
//  LloydsLastFMTestTests
//
//  Created by Sean Lintern on 12/03/2019.
//  Copyright © 2019 Sean Lintern LTD. All rights reserved.
//

import XCTest
@testable import LloydsLastFMTest

class CoordinatorTests: XCTestCase {

    func testCoordinator() {
        let navigationController = UINavigationController()
        let _ = Coordinator(navigationController: navigationController)
        XCTAssert(navigationController.viewControllers.count == 0)
    }
    
    func testAppCoordinator() {
        let navigationController = UINavigationController()
        let _ = AppCoordinator(launchOptions: nil, navigationController: navigationController)
        XCTAssert(navigationController.viewControllers.count == 1)
    }
    
    func testAlbumListCoordinator() {
        let navigationController = UINavigationController()
        let coordinator = AlbumListCoordinator(navigationController: navigationController)
        XCTAssert(navigationController.viewControllers.count == 0)
        coordinator.start()
        XCTAssert(navigationController.viewControllers.count == 1)
    }
    
    func testAlbumDetailsCoordinatorCoordinator() {
        let navigationController = UINavigationController()
        let coordinator = AlbumDetailsCoordinator(navigationController: navigationController)
        XCTAssert(navigationController.viewControllers.count == 0)
        coordinator.start(album: LastFMAlbum(name: "", artist: "", url: URL(string: "http://google.com")!, image: [], streamable: "", mbid: ""))
        XCTAssert(navigationController.viewControllers.count == 1)
    }
}
