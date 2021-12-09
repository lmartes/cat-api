import Foundation
import Alamofire
import ObjectMapper

struct CatAPIManager {
    func requestCatAPI() {
//        let url = "https://api.thecatapi.com/v1/images/search"
//        let apiKey = "api_key=f227d41d-60de-4c96-b588-2cdba266e0ba"
        let urlString = "https://api.thecatapi.com/v1/images/search?breed_ids=beng"
        performRequest(urlString)
    }
    
    func performRequest(_ urlString: String) {
        AF.request(urlString).response { response in
            if let error = response.error {
                print("Request ERROR")
                return
            }
            
            if let data = response.data {
                parseJSON(data)
            }
        }
    }
    
    func parseJSON(_ data: Data) {
        do {
            let str = try String(decoding: data, as: UTF8.self)
            
            guard let decodedData = Mapper<CatAPIData>().map(JSONString: str) else {
                return
            }
            let id = decodedData.getID()
            let url = decodedData.getUrl()
            print("ID: ", id, " - ", "URL: ", url)
        } catch {
            print("ERROR")
        }
    }
}
