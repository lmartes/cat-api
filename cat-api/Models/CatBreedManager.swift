import Foundation
import Alamofire
import ObjectMapper

class CatBreedManager {
    let apiKey = "api_key=f227d41d-60de-4c96-b588-2cdba266e0ba"
    var delegate: CatBreedManagerDelegate?
    var catsByBreed: [CatBreedResponse] = []
    
    func fetchBreeds() {
        self.delegate?.didLoadRequest()
        let url = "https://api.thecatapi.com/v1/breeds?\(apiKey)&limit=20&page=0"
        AF.request(url).responseJSON { (response) in
            if let error = response.error {
                self.delegate?.didFailWithError(error: error)
            }
            
            if let data = response.data {
                self.parseJSON(data)
                self.getCatBreed()
            }
            self.delegate?.didFinishRequest()
        }
    }
    
    private func parseJSON(_ data: Data) {
        let str = String(decoding: data, as: UTF8.self)
        guard let cats = Mapper<CatBreedResponse>().mapArray(JSONString: str) else {
            print("No se pudo mappear la respuesta")
            return
        }
        catsByBreed = cats
    }
    
    func getCatBreed() {
        if catsByBreed.count <= 0 {
            self.delegate?.didFinishVote()
            return
        }
        
        guard let cat = catsByBreed.first else {
            return
        }
        
        catsByBreed.removeFirst()
        self.delegate?.didBreedUpdate(self, catByBreed: cat)
    }

}
