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
        stack.spacing = 8
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
        imageView.layer.cornerRadius = 4
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private var imageResource: ImageResource? {
        didSet {
            if let old = oldValue {
                ImageLoader.shared.cancelRequest(resource: old)
            }
            if let resource = imageResource {
                displayImage.loadImage(resource: resource)
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        accessoryType = .disclosureIndicator
        
        contentView.addSubview(horizontalStackLayout)
        horizontalStackLayout.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(8)
        }
        
        horizontalStackLayout.addArrangedSubview(displayImage)
        
        displayImage.snp.makeConstraints { (make) in
            make.size.equalTo(50).priority(999)
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
        
        self.imageResource = imageResource
        self.displayImage.isHidden = imageResource == nil
    }
}
