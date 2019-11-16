import Foundation

struct PhotoResponse: Codable {
    
    fileprivate var collection: PhotoCollection
    var original: String { return collection.items[0].href }
    
}

struct PhotoCollection: Codable {
        
    fileprivate var items: [Photo]
    
}

struct Photo: Codable {
    
    fileprivate var href: String
    
}
