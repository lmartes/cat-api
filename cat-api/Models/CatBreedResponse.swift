import Foundation
import ObjectMapper

struct CatBreedResponse: Mappable {
    private var id: String = ""
    private var name: String = ""
    private var image: CatBreedImage?
    private var like: Bool = false
    private var date: Date?
    
    init() {}
    
    init(like: Bool, date: Date) {
        self.like = like
        self.date = date
    }
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        image <- map["image"]
    }
    
    func getID() -> String {
        return id
    }
    
    func getName() -> String {
        return name
    }
    
    func getCatBreedImage() -> CatBreedImage {
        return image!
    }
}
