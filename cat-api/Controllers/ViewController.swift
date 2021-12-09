import UIKit

class ViewController: UIViewController {
    static var apiKey = "api_key=f227d41d-60de-4c96-b588-2cdba266e0ba"
    static var url = "https://api.thecatapi.com/v1/images/search"
    
    @IBOutlet weak var breedTitle: UILabel!
    @IBOutlet weak var breedImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func requestCatAPI() {
    }

    @IBAction func actionLike(_ sender: Any) {
    }
    
    @IBAction func actionDislike(_ sender: Any) {
    }
}

