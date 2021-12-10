import Foundation
import ObjectMapper

struct CatBreedImage: Mappable {
    private var id: String = ""
    private var url: String = ""
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        url <- map["url"]
    }
    
    func getId() -> String {
        return id
    }
    
    func getURL() -> URL? {
        return URL(string: url)
    }
    
}
