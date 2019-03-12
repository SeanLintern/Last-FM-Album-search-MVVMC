//
//  ImageLoader.swift
//
//  Created by Sean Lintern on 08/11/2018.
//  Copyright © 2018 Sean Lintern LTD. All rights reserved.
//

import UIKit

typealias ImageLoadingCompletion = ((_ image: UIImage?) -> Void)

private typealias ImageResourceLoadingComplete = ((_ image: UIImage?, _ resource: ImageResource) -> Void)

private class ImageLoadingRequestOperation: Operation {
    
    var resource: ImageResource
    private var session: URLSession
    private var completion: ImageResourceLoadingComplete?

    override var isAsynchronous: Bool {
        return true
    }
    
    override var isExecuting: Bool {
        return !completed
    }
    
    override var isFinished: Bool {
        return completed
    }
    
    /// Prevents the operation reporting as completed through super methods
    /// before the async operation is actually complete.
    private var completed: Bool = false
    
    init(resource: ImageResource, session: URLSession, completion: ImageResourceLoadingComplete?) {
        self.resource = resource
        self.session = session
        self.completion = completion
    }
    
    override func start() {
        super.start()
        
        session.dataTask(with: resource.resourceURL) { [weak self] (data, _, _) in
            self?.complete(data: data)
        }.resume()
    }
    
    private func complete(data: Data?) {
        guard !isCancelled else { // been cancelled
            completion?(nil, resource)
            completed = true
            return
        }
        
        guard let imageData = data else {
            completion?(nil, resource)
            return
        }
        
        completion?(UIImage(data: imageData), resource)
        completed = true
    }
}

class ImageLoader {
    
    private var cache: NSCache<AnyObject, UIImage>
    
    private var requestQueue: OperationQueue
    
    private var requestStore = [String: [ImageLoadingCompletion?]]()
    
    private var session: URLSession
    
    static let shared = ImageLoader(cache: NSCache(), queue: OperationQueue(), session: URLSession.shared)
    
    init(cache: NSCache<AnyObject, UIImage>, queue: OperationQueue, session: URLSession) {
        self.cache = cache
        self.requestQueue = queue
        self.session = session
    }
    
    func request(resource: ImageResource, completion: ImageLoadingCompletion?) {
        if let cachedImage = cache.object(forKey: resource.identifier as AnyObject) {
            completion?(cachedImage)
            return
        }
        if var existingRequests = requestStore[resource.identifier] {
            existingRequests.append(completion)
            requestStore[resource.identifier] = existingRequests
            return
        }
        
        let newRequest = ImageLoadingRequestOperation(resource: resource, session: session, completion: { [weak self] image, resource in
            self?.requestCompleted(image: image, resource: resource)
        })
        requestStore[resource.identifier] = [completion]
        requestQueue.addOperation(newRequest)
    }
    
    func cancelRequest(resource: ImageResource) {
        requestQueue.operations.forEach({
            if let op = $0 as? ImageLoadingRequestOperation, op.resource.identifier == resource.identifier {
                $0.cancel()
            }
        })
    }
    
    private func requestCompleted(image: UIImage?, resource: ImageResource) {
        let requests = requestStore[resource.identifier]
        
        for request in requests ?? [] {
            DispatchQueue.main.async {
                request?(image)
            }
        }
        
        guard let verifiedImage = image else { return }
        
        cache.setObject(verifiedImage, forKey: resource.identifier as AnyObject)
    }
}
