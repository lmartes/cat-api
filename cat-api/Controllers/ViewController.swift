import UIKit
import Alamofire
import ObjectMapper
import SVProgressHUD

class ViewController: UIViewController {
    @IBOutlet weak var breedTitle: UILabel!
    @IBOutlet weak var breedImage: UIImageView!
    private var catsByBreed: [CatBreedResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestCatAPI()
    }
    
    func requestCatAPI() {
        //let apiKey = "api_key=f227d41d-60de-4c96-b588-2cdba266e0ba"
        let url = "https://api.thecatapi.com/v1/breeds?limit=20&page=0"
        SVProgressHUD.show()
        AF.request(url).responseJSON { (response) in
            SVProgressHUD.dismiss()
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
        guard let cats = Mapper<CatBreedResponse>().mapArray(JSONString: str) else {
            return
        }
        
        catsByBreed = cats
        DispatchQueue.main.async {
            self.updateUI()
        }
    }
    
    func updateUI() {
        if catsByBreed.count <= 0 {
            return
        }
        
        let breedName = catsByBreed.first?.getName()
        breedTitle.text = breedName
        
        guard let breedImageURL = catsByBreed.first?.getCatBreedImage().getURL(), let data = try? Data(contentsOf: breedImageURL) else {
            return
        }
        self.breedImage.image = UIImage(data: data)
        
        catsByBreed.removeFirst()
    }
    
// MARK: - IBActions
    @IBAction func actionLike(_ sender: Any) {
        updateUI()
    }
    
    @IBAction func actionDislike(_ sender: Any) {
        updateUI()
    }
}

