//
//  LoadingStateView.swift
//  LloydsLastFMTest
//
//  Created by Sean Lintern on 12/03/2019.
//  Copyright © 2019 Sean Lintern LTD. All rights reserved.
//

import Foundation

enum LoadingState {
    case loading
    case loadingComplete
}

protocol LoadingStateView: class {
    func loadingStateUpdated(newState: LoadingState)
}
