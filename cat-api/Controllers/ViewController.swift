import UIKit
import Alamofire
import ObjectMapper

class ViewController: UIViewController {
    @IBOutlet weak var breedTitle: UILabel!
    @IBOutlet weak var breedImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func actionLike(_ sender: Any) {
        requestCatAPI()
    }
    
    func requestCatAPI() {
        let url = "https://api.thecatapi.com/v1/images/search?api_key=f227d41d-60de-4c96-b588-2cdba266e0ba"
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
        guard let cats = Mapper<CatAPIData>().mapArray(JSONString: str) else {
            return
        }
        
        let firstID = cats.first?.getID()
        print("ID: ", firstID)
    }
    
    @IBAction func actionDislike(_ sender: Any) {
    }
}

