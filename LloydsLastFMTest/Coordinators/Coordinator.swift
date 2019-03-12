//
//  Coordinator.swift
//  LloydsLastFMTest
//
//  Created by Sean Lintern on 12/03/2019.
//  Copyright © 2019 Sean Lintern LTD. All rights reserved.
//

import UIKit

class Coordinator {
    
    var navigationController: UINavigationController
    
    private var parent: Coordinator?
    
    private var children: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
 
    func addChild(coordinator: Coordinator) {
        coordinator.parent = self
        children.append(coordinator)
    }
}
