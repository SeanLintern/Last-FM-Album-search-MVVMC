//
//  AlbumListViewController.swift
//  LloydsLastFMTest
//
//  Created by Sean Lintern on 12/03/2019.
//  Copyright © 2019 Sean Lintern LTD. All rights reserved.
//

import UIKit
import SnapKit

protocol AlbumListViewControllerDelegate: class {
    
}

class AlbumListViewController: UIViewController {

    private weak var delegate: AlbumListViewControllerDelegate?
    
    init(delegate: AlbumListViewControllerDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}
