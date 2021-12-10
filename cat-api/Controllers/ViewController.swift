import UIKit
import Alamofire
import ObjectMapper

class ViewController: UIViewController {
    @IBOutlet weak var breedTitle: UILabel!
    @IBOutlet weak var breedImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestCatAPI()
    }

    func requestCatAPI() {
        let apiKey = "api_key=f227d41d-60de-4c96-b588-2cdba266e0ba"
        let url = "https://api.thecatapi.com/v1/breeds?limit=20"
        performRequest(url)
    }
    
    func performRequest(_ urlString: String) {
        AF.request(urlString).responseJSON { (response) in
            if let error = response.error {
                print("Error: ", error)
            }
            
            if let data = response.data {
                self.parseJSON(data)
            }
        }
    }
    
    func parseJSON(_ data: Data) {
        let str = String(decoding: data, as: UTF8.self)
        guard let cat = Mapper<CatBreedResponse>().mapArray(JSONString: str) else {
            return
        }
        
        let breedName = cat.first?.getName()
        breedTitle.text = breedName
        
        guard let breedImageURL = cat.first?.getCatBreedImage().getURL(), let data = try? Data(contentsOf: breedImageURL) else {
            return
        }
        self.breedImage.image = UIImage(data: data)
    }
    
// MARK: - IBActions
    @IBAction func actionLike(_ sender: Any) {
    }
    
    @IBAction func actionDislike(_ sender: Any) {
    }
}

