import UIKit
import SVProgressHUD

class ViewController: UIViewController, CatBreedManagerDelegate {
    @IBOutlet weak var breedTitle: UILabel!
    @IBOutlet weak var breedImage: UIImageView!
    @IBOutlet weak var breedActionsView: UIView!
    var catBreedManager: CatBreedManager = CatBreedManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        catBreedManager.delegate = self
        catBreedManager.fetchBreeds()
    }
    
    func didLoadRequest() {
        SVProgressHUD.show()
        breedTitle.isHidden = true
        breedImage.isHidden = true
        breedActionsView.isHidden = true
    }
    
    func didFinishRequest() {
        SVProgressHUD.dismiss()
        breedTitle.isHidden = false
        breedImage.isHidden = false
        breedActionsView.isHidden = false
    }
    
    func didBreedUpdate(_ catBreedManager: CatBreedManager, catByBreed: CatBreedResponse) {
        DispatchQueue.main.async {
            self.breedTitle.text = catByBreed.getName()
            guard let breedImageURL = catByBreed.getCatBreedImage().getURL(), let data = try? Data(contentsOf: breedImageURL) else {
                return
            }
            self.breedImage.image = UIImage(data: data)
        }
    }
    
    func didFailWithError(error: Error) {
        print("Error: ", error)
    }
    
// MARK: - IBActions
    @IBAction func actionLike(_ sender: Any) {
        catBreedManager.getCatBreed()
    }
    
    @IBAction func actionDislike(_ sender: Any) {
        catBreedManager.getCatBreed()
    }
}

