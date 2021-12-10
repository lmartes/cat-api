import UIKit
import SVProgressHUD

class ViewController: UIViewController, CatBreedManagerDelegate {
    @IBOutlet weak var breedTitle: UILabel!
    @IBOutlet weak var breedImage: UIImageView!
    @IBOutlet weak var breedActionsView: UIView!
    private var catBreedManager: CatBreedManager = CatBreedManager()
    private var catBreedResponse: CatBreedResponse = CatBreedResponse()
    private var storeDefaultsCatBreeds: [CatBreedResponse] = []
    
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
        catBreedResponse = catByBreed
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
        saveUserDefaults(withActionsLike: true)
        catBreedManager.getCatBreed()
    }
    
    /// guard let str = defaults.string(forKey: UserDefaultsKeys.catBreeds.rawValue) else {
    ///     return
    /// }
    /// print(str)
    @IBAction func actionDislike(_ sender: Any) {
        saveUserDefaults(withActionsLike: false)
        catBreedManager.getCatBreed()
    }
    
    private func saveUserDefaults(withActionsLike: Bool) {
        catBreedResponse.setAction(like: withActionsLike, date: getCurrentDateString())
        storeDefaultsCatBreeds.append(catBreedResponse)
        guard let data = storeDefaultsCatBreeds.toJSONString(prettyPrint: false) else {
            return
        }
        UserDefaults.standard.set(data, forKey: UserDefaultsKeys.catBreeds.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    private func getCurrentDateString() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY/MM/dd"
        return dateFormatter.string(from: date)
    }
}
