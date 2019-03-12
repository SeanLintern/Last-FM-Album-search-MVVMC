//
//  ImageResource.swift
//
//  Created by Sean Lintern on 08/11/2018.
//  Copyright © 2018 Sean Lintern LTD. All rights reserved.
//

import Foundation

protocol ImageResource {
    var resourceURL: URL {get}
    var identifier: String {get}
}

extension LastFMImage: ImageResource {
    var resourceURL: URL {
        return URL(string: text)!
    }
    
    var identifier: String {
        return resourceURL.path
    }
}
