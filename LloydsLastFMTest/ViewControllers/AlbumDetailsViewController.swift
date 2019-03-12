//
//  AlbumDetailsViewController.swift
//  LloydsLastFMTest
//
//  Created by Sean Lintern on 12/03/2019.
//  Copyright © 2019 Sean Lintern LTD. All rights reserved.
//

import UIKit

class AlbumDetailsViewController: UIViewController {

    fileprivate lazy var loadingSpinner: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        loader.hidesWhenStopped = true
        return loader
    }()
    
    private lazy var verticalTextStackLayout: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 16
        return stack
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var displayImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    fileprivate var viewModel: AlbumDetailsViewModel?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(loadingSpinner)
        loadingSpinner.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    private func updateUI(viewModel: AlbumDetailsViewModel) {
        navigationItem.title = viewModel.title.string
        
        view.addSubview(verticalTextStackLayout)
        verticalTextStackLayout.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.topMargin).inset(32)
            make.bottom.lessThanOrEqualToSuperview().inset(32)
            make.width.equalToSuperview().inset(32)
            make.centerX.equalToSuperview()
        }
        
        verticalTextStackLayout.addArrangedSubview(displayImage)
        displayImage.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(verticalTextStackLayout.snp.width)
        }
        
        let textStack = UIStackView()
        textStack.spacing = 4
        textStack.axis = .vertical
        textStack.addArrangedSubview(titleLabel)
        textStack.addArrangedSubview(subtitleLabel)
        
        verticalTextStackLayout.addArrangedSubview(textStack)
        
        titleLabel.attributedText = viewModel.title
        subtitleLabel.attributedText = viewModel.subtitle
        
        if let image = viewModel.image {
            displayImage.loadImage(resource: image)
        }
    }
}

extension AlbumDetailsViewController: LoadingStateView {
    func loadingStateUpdated(newState: LoadingState) {
        switch newState {
        case .loading:
            loadingSpinner.startAnimating()
        case .loadingComplete:
            loadingSpinner.stopAnimating()
        }
    }
}

