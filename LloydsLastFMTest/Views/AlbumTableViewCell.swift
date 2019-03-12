//
//  AlbumTableViewCell.swift
//  LloydsLastFMTest
//
//  Created by Sean Lintern on 12/03/2019.
//  Copyright © 2019 Sean Lintern LTD. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    private lazy var horizontalStackLayout: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .top
        stack.spacing = 4
        return stack
    }()
    
    private lazy var verticalTextStackLayout: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .top
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
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        contentView.addSubview(horizontalStackLayout)
        horizontalStackLayout.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(8)
        }
        
        horizontalStackLayout.addArrangedSubview(displayImage)
        
        displayImage.snp.makeConstraints { (make) in
            make.size.equalTo(50)
        }
    
        horizontalStackLayout.addArrangedSubview(verticalTextStackLayout)
        verticalTextStackLayout.addArrangedSubview(titleLabel)
        verticalTextStackLayout.addArrangedSubview(subtitleLabel)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        displayImage.image = nil
    }
    
    func configure(title: NSAttributedString, subtitle: NSAttributedString?, imageResource: ImageResource?) {
        titleLabel.attributedText = title
        subtitleLabel.attributedText = subtitle
        
        subtitleLabel.isHidden = subtitle == nil
        
        if let resource = imageResource {
            displayImage.loadImage(resource: resource)
        }
    }
}
