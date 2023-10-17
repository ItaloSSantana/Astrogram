import Foundation

protocol ProfilePresenting: AnyObject {
    func displayScreen(user: UserDataViewModel, posts: [PostViewModel])
    func validateUser(validate: Bool)
    func returnPressed()
    func validadeFollowerCount(validate: Int)
    func validadeFollowingCount(validate: Int)
    func validatePostCount(validate: Int)
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
    
    func validadeFollowerCount(validate: Int) {
        viewController?.validateFollowerCount(validate: validate)
    }
    
    func validadeFollowingCount(validate: Int) {
        viewController?.validadeFollowingCount(validate: validate)
    }
    
    func validatePostCount(validate: Int){
        viewController?.validatePostCount(validate: validate)
    }
}
