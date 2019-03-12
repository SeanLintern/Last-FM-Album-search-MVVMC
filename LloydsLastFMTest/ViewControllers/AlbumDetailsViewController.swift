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
    
    private lazy var scrollContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    private lazy var verticalStackLayout: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 16
        return stack
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
    
    func updateUI(viewModel: AlbumDetailsViewModel) {
        navigationItem.title = viewModel.title.string
        
        scrollView.contentInset = UIEdgeInsets(top: 32, left: 0, bottom: 32, right: 0)
        
        view.addSubview(scrollContainer)
        scrollContainer.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.topMargin)
            make.bottom.lessThanOrEqualToSuperview()
            make.width.equalToSuperview().inset(32)
            make.centerX.equalToSuperview()
        }
        
        scrollContainer.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(verticalStackLayout)
        verticalStackLayout.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollContainer)
        }
        
        verticalStackLayout.addArrangedSubview(displayImage)
        displayImage.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(verticalStackLayout.snp.width)
        }
        
        if let image = viewModel.image {
            displayImage.loadImage(resource: image)
        }
        displayImage.isHidden = viewModel.image == nil

        verticalStackLayout.addArrangedSubview(verticalTextStackGenerator(spacing: 0, title: viewModel.detailsHeader, subtitle: nil))
        verticalStackLayout.addArrangedSubview(verticalTextStackGenerator(spacing: 4, title: viewModel.title, subtitle: viewModel.subtitle))
        
        if let wiki = viewModel.wikiText {
            verticalStackLayout.addArrangedSubview(verticalTextStackGenerator(spacing: 0, title: wiki, subtitle: nil))
        }
        
        verticalStackLayout.addArrangedSubview(verticalTextStackGenerator(spacing: 0, title: viewModel.trackHeader, subtitle: nil))

        for i in 0..<viewModel.trackCount {
            verticalStackLayout.addArrangedSubview(verticalTextStackGenerator(spacing: 0, title: viewModel.trackTitle(at: i), subtitle: viewModel.trackSubtitle(at: i)))
        }
    }
    
    private func verticalTextStackGenerator(spacing: CGFloat, title: NSAttributedString, subtitle: NSAttributedString?) -> UIStackView {
        let stack = UIStackView()
        stack.spacing = spacing
        stack.axis = .vertical
        
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.attributedText = title
        stack.addArrangedSubview(titleLabel)

        if let subtitle = subtitle {
            let subtitleLabel = UILabel()
            subtitleLabel.numberOfLines = 0
            subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
            subtitleLabel.attributedText = subtitle
            stack.addArrangedSubview(subtitleLabel)
        }

        return stack
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

