import Foundation
import ObjectMapper

struct CatAPIData: Mappable {
    private var id: String = ""
    private var url: String = ""
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        url <- map["url"]
    }
    
    func getID() -> String {
        return id
    }
    
    func getUrl() -> String {
        return url
    }
}
