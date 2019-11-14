import Foundation

struct Photo: Codable {
    
    var id: UUID?
    
    var copyright: String?
    
    var date, title, explanation, url: String
    
}
