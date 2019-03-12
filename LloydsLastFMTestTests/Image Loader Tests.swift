import XCTest
@testable import LloydsLastFMTest

class ImageLoaderTests: XCTestCase {
    
    private var testCache: NSCache<AnyObject, UIImage>!
    private var testLoader: ImageLoader!
    private var testQueue: OperationQueue!
    
    override func setUp() {
        testCache = NSCache<AnyObject, UIImage>()
        testQueue =  OperationQueue()
        testLoader = ImageLoader(cache: testCache, queue: testQueue, session: URLSession.shared)
        testQueue.isSuspended = true // This prevents ops being completed
        super.setUp()
    }
    
    override func tearDown() {
        testCache.removeAllObjects()
        testQueue.operations.forEach({ $0.cancel() })
        
        super.tearDown()
    }
    
    func testDuplicates() {
        let firstTestResource = LastFMImage(text: "http://image.com/1", size: .small)
        let secondTestResource = LastFMImage(text: "http://image.com/2", size: .medium)
        
        testLoader.request(resource: firstTestResource, completion: nil)
        testLoader.request(resource: firstTestResource, completion: nil)
        
        XCTAssert(testQueue.operations.count == 1)
        
        testLoader.request(resource: secondTestResource, completion: nil)
        
        XCTAssert(testQueue.operations.count == 2)
    }
    
    func testCacheControl() {
        let potentialImageURL = Bundle(for: ImageLoaderTests.self).url(forResource: "thumb", withExtension: "jpg")
        
        guard let imageURL = potentialImageURL,
            let imageData = try? Data(contentsOf: imageURL),
            let image = UIImage(data: imageData) else {
            XCTFail("Couldnt load test image data")
            return
        }
        let resourceID = "1"
        let firstTestResource = LastFMImage(text: "http://image.com/\(resourceID)", size: .small)

        testCache.setObject(image, forKey: resourceID as AnyObject)
        
        testLoader.request(resource: firstTestResource) { (image) in
            XCTAssertNotNil(image)
        }
    }
}
