import Foundation

struct SearchResponse: Codable {
    
    fileprivate var collection: Collection
    var items: [Item] { return collection.items }
}

struct Collection: Codable {
        
    fileprivate var items: [Item]
    
}

struct Link: Codable {
    
    fileprivate var href: String
    
}

struct ItemData: Codable {

    var title, description, nasa_id: String?
    
}

struct Item: Codable {
    
    fileprivate var data: [ItemData]
    fileprivate var links: [Link]?
    
    var title: String? { return data[0].title }
    var description: String? { return data[0].description }
    var nasa_id: String? { return data[0].nasa_id }
    var pic: String { return links?[0].href ?? "" }
    
}
