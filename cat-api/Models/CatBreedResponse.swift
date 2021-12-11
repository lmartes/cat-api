import Foundation
import ObjectMapper

struct CatBreedResponse: Mappable {
    private var id: String = ""
    private var name: String = ""
    private var image: CatBreedImage?
    private var like: Bool = false
    private var date: String = ""
    
    init() {}
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        image <- map["image"]
        like <- map["like"]
        date <- map["date"]
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
    
    func getLike() -> Bool {
        return like
    }
    
    func getDate() -> String {
        return date
    }
    
    mutating func setAction(like: Bool, date: String) {
        self.like = like
        self.date = date
    }
}
