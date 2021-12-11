import Foundation
import ObjectMapper

struct CatBreedDetailResponse: Mappable {
    private var name: String = ""
    private var description: String = ""
    private var wikipediaUrl: String = ""
    
    init() {}
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        description <- map["description"]
        wikipediaUrl <- map["wikipedia_url"]
    }
    
    func getName() -> String {
        return name
    }
    
    func getDescription() -> String {
        return description
    }
    
    func getWikipediaUrl() -> String {
        return wikipediaUrl
    }
}
