import UIKit
import Alamofire
import ObjectMapper
import SVProgressHUD

class ViewController: UIViewController {
    @IBOutlet weak var breedTitle: UILabel!
    @IBOutlet weak var breedImage: UIImageView!
    @IBOutlet weak var breedActionsView: UIView!
    private var catsByBreed: [CatBreedResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestCatAPI()
    }
    
    func requestCatAPI() {
        loadingRequest()
        //let apiKey = "api_key=f227d41d-60de-4c96-b588-2cdba266e0ba"
        let url = "https://api.thecatapi.com/v1/breeds?limit=20&page=0"
        AF.request(url).responseJSON { (response) in
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
            self.finishingRequest()
        }
    }
    
    private func loadingRequest() {
        SVProgressHUD.show()
        breedTitle.isHidden = true
        breedImage.isHidden = true
        breedActionsView.isHidden = true
    }
    
    private func finishingRequest() {
        SVProgressHUD.dismiss()
        breedTitle.isHidden = false
        breedImage.isHidden = false
        breedActionsView.isHidden = false
    }
    
    func updateUI() {
        if catsByBreed.count <= 0 {
            return
        }
        
        guard let cat = catsByBreed.first else {
            return
        }
        
        let breedName = cat.getName()
        breedTitle.text = breedName
        
        guard let breedImageURL = cat.getCatBreedImage().getURL(), let data = try? Data(contentsOf: breedImageURL) else {
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

