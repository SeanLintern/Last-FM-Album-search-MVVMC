//
//  UIImageView+Lloyds.swift
//  LloydsLastFMTest
//
//  Created by Sean Lintern on 12/03/2019.
//  Copyright © 2019 Sean Lintern LTD. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImage(resource: ImageResource) {
        ImageLoader.shared.request(resource: resource) { [weak self] (image) in
            self?.image = image
        }
    }
}
