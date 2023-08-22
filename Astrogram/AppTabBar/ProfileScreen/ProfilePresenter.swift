import Foundation

protocol ProfilePresenting: AnyObject {
    func displayScreen(user: UserDataViewModel, posts: [PostViewModel])
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
    
    func performAction() {
        // :- NEXT PR
    }
}
