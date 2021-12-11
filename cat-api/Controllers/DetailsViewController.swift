import UIKit
import Alamofire
import ObjectMapper

/// Identifier: detailsViewControllerIdentifier
class DetailsViewController: UIViewController {
    @IBOutlet weak var nameDetail: UILabel!
    @IBOutlet weak var descriptionDetail: UILabel!
    @IBOutlet weak var urlDetail: UILabel!
    private var breedDetail: CatBreedDetailResponse = CatBreedDetailResponse()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func fetchBreedsById(withId id: String) {
        let apiKey = "api_key=f227d41d-60de-4c96-b588-2cdba266e0ba"
        let url = "https://api.thecatapi.com/v1/breeds/\(id)?\(apiKey)"
        AF.request(url).responseJSON { (response) in
            if let error = response.error {
                print("Error: ", error)
            }
            
            if let data = response.data {
                self.parseJSON(data)
                self.setupView()
            }
        }
    }
    
    private func parseJSON(_ data: Data) {
        let data = String(decoding: data, as: UTF8.self)
        guard let breedDetailResponse = Mapper<CatBreedDetailResponse>().map(JSONString: data) else {
            print("No se pudo mappear la respuesta")
            return
        }
        breedDetail = breedDetailResponse
    }
    
    private func setupView() {
        nameDetail.text = breedDetail.getName()
        descriptionDetail.text = breedDetail.getDescription()
        urlDetail.text = "Wikipedia: \(breedDetail.getWikipediaUrl())"
    }
}
