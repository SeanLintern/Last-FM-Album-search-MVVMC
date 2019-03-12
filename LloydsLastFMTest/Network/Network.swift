//
//  Network.swift
//  LloydsLastFMTest
//
//  Created by Sean Lintern on 12/03/2019.
//  Copyright © 2019 Sean Lintern LTD. All rights reserved.
//

import Foundation

typealias NetworkSuccess = (_ result: Data?, _ response: URLResponse?) -> Void
typealias NetworkFailure = (_ reason: FailureType, _ code: Int, _ errorDescription: String?, _ data: Data?) -> Void

enum FailureType {
    case authentication
    case timeout
    case noData
    case JSON
    case other
}

enum requestType: String {
    case get = "GET"
}

struct NetworkManager {
    
    static func createRequest(url: URL, additionalHeaders: [String: String]?, type: requestType, body: Data?) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpBody = body
        request.allHTTPHeaderFields = additionalHeaders
        request.httpMethod = type.rawValue
        return request
    }
    
    static func performRequest(request: URLRequest, success: NetworkSuccess?, failure: NetworkFailure?) {
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                let code = httpResponse.statusCode
                switch code {
                case 200..<300:
                    DispatchQueue.main.async {
                        success?(data, response)
                    }

                default:
                    DispatchQueue.main.async {
                        failure?(.other, code, error.debugDescription, data)
                    }
                }
            } else if let error = error as NSError? {
                DispatchQueue.main.async {
                    failure?(.timeout, error.code, error.localizedDescription, nil)
                }
            }
        }.resume()
    }
}
