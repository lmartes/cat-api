import Foundation

protocol CatBreedManagerDelegate {
    func didLoadRequest()
    func didFinishRequest()
    func didBreedUpdate(_ catBreedManager: CatBreedManager, catByBreed: CatBreedResponse)
    func didFailWithError(error: Error)
}
