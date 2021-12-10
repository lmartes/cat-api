import Foundation
import ObjectMapper

struct CatBreedResponse: Mappable {
    private var id: String = ""
    private var name: String = ""
    private var image: CatBreedImage?
    
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
