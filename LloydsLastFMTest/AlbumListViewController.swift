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
    func albumListDidSearch(controller: AlbumListViewController, searchTerm: String)
    func albumListDidSelectAlbum(controller: AlbumListViewController, album: LastFMAlbum)
}

class AlbumListViewController: UIViewController {

    fileprivate lazy var loadingSpinner: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        loader.hidesWhenStopped = true
        return loader
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        return table
    }()
    
    private lazy var searchBar: UISearchBar = {
        let bar = UISearchBar(frame: .zero)
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.delegate = self
        return bar
    }()
    
    fileprivate var viewModel: AlbumListViewModel? {
        didSet {
            tableView.reloadData()
        }
    }
    
    fileprivate weak var delegate: AlbumListViewControllerDelegate?
    
    init(delegate: AlbumListViewControllerDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Albums"
        
        tableView.registerClasses(classes: [AlbumTableViewCell.self])
        
        view.addSubview(loadingSpinner)
        loadingSpinner.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = loadingSpinner
        tableView.tableHeaderView = searchBar
        
        searchBar.snp.makeConstraints { (make) in
            make.width.equalTo(tableView.snp.width)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let selected = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selected, animated: true)
        }
    }
    
    func update(viewModel: AlbumListViewModel) {
        self.viewModel = viewModel
    }
}

extension AlbumListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfItems ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AlbumTableViewCell = tableView.dequeueCell(atIndexPath: indexPath)
        
        if let model = viewModel {
            cell.configure(title: model.title(for: indexPath), subtitle: model.subtitle(for: indexPath), imageResource: model.imageResource(for: indexPath))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let album = viewModel?.album(for: indexPath) {
            delegate?.albumListDidSelectAlbum(controller: self, album: album)
        }
    }
}

extension AlbumListViewController: LoadingStateView {
    func loadingStateUpdated(newState: LoadingState) {
        switch newState {
        case .loading:
            loadingSpinner.startAnimating()
        case .loadingComplete:
            loadingSpinner.stopAnimating()
        }
    }
}

extension AlbumListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let term = searchBar.text, term.count > 0, !term.isEmpty {
            viewModel = nil
            delegate?.albumListDidSearch(controller: self, searchTerm: term)
        }
        searchBar.resignFirstResponder()
    }
}
