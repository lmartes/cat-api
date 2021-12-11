import UIKit
import ObjectMapper

/// Identifier: historyViewControllerIdentifier
class HistoryViewController: UIViewController {
    @IBOutlet weak var historyTableView: UITableView!
    private var catsByBreed: [CatBreedResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDefaults()
        setDelegates()
    }
    
    private func getDefaults() {
        guard let catBreedsDefaults = UserDefaults.standard.string(forKey: UserDefaultsKeys.catBreeds.rawValue) else {
            return
        }
        
        guard let cats = Mapper<CatBreedResponse>().mapArray(JSONString: catBreedsDefaults) else {
            print("No se pudo mappear la respuesta")
            return
        }
        catsByBreed = cats
    }
    
    private func setDelegates() {
        historyTableView.delegate = self
        historyTableView.dataSource = self
    }

}

// MARK: - UITableView Delegates
extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catsByBreed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let historyDetailCell = tableView.dequeueReusableCell(withIdentifier: "historyDetailCellIdentifier") as? HistoryDetailTableViewCell else {
            return UITableViewCell()
        }
        historyDetailCell.setupView(catBreed: catsByBreed[indexPath.row])
        return historyDetailCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let idBreed = catsByBreed[indexPath.row].getId()
        self.performSegue(withIdentifier: "goToDetailViewController", sender: idBreed)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "goToDetailViewController", let detailViewController = segue.destination as? DetailsViewController else {
            return
        }
        
        if let id = sender as? String {
            detailViewController.fetchBreedsById(withId: id)
        }
    }
}
