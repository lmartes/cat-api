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
    
    func getImage() -> UIImage? {
        guard let breedImageURL = getURL(), let data = try? Data(contentsOf: breedImageURL) else {
            return UIImage(named: "cat-icon")
        }
        return UIImage(data: data)
    }
    
    private func getURL() -> URL? {
        return URL(string: url)
    }
    
}
