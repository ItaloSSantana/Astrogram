import Foundation

protocol ProfilePresenting: AnyObject {
    func displayScreen(user: UserDataViewModel, posts: [PostViewModel])
    func validateUser(validate: Bool)
    func returnPressed()
}

final class ProfilePresenter: ProfilePresenting {
    weak var viewController: ProfileDisplaying?
    private let coordinator: ProfileCoordinating
    
    init(coordinator: ProfileCoordinating) {
        self.coordinator = coordinator
    }
    
    func displayScreen(user: UserDataViewModel, posts: [PostViewModel]) {
        viewController?.dataLoaded(user: user, posts: posts)
    }
    
    func validateUser(validate: Bool) {
        viewController?.validateUser(validate: validate)
    }
    
    func returnPressed() {
        coordinator.returnPressed()
    }
}
