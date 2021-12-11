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
        breedImageAction.image = getBreedImageAction(like: catBreed.getLike())
    }
    
    private func getBreedImageAction(like: Bool) -> UIImage? {
        return like ? UIImage(named: "like-icon") : UIImage(named: "dislike-icon")
    }

}
