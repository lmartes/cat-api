import UIKit

/// identifier: historyDetailCellIdentifier
class HistoryDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var breedImage: UIImageView!
    @IBOutlet weak var breedName: UILabel!
    @IBOutlet weak var breedDate: UILabel!
    @IBOutlet weak var breedImageAction: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupView(catBreed: CatBreedResponse) {
        breedImage.image = catBreed.getCatBreedImage().getImage()
        breedName.text = catBreed.getName()
        breedDate.text = catBreed.getDate()
        setBreedImageAction(like: catBreed.getLike())
    }
    
    private func setBreedImageAction(like: Bool) {
        if like {
            breedImageAction.image = UIImage(named: "like-icon")
            return
        }
        breedImageAction.image = UIImage(named: "dislike-icon")
    }

}
