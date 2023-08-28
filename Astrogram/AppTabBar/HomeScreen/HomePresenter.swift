import Foundation

protocol HomePresenting: AnyObject {
    func displayScreen(posts: [PostViewModel])
    func loadCurrentUserData(user: UserDataViewModel)
    func searchPressed()
}

final class HomePresenter: HomePresenting {
    weak var viewController: HomeDisplaying?
    private let coordinator: HomeCoordinating
    
    init(coordinator: HomeCoordinating) {
        self.coordinator = coordinator
    }
    
    func displayScreen(posts: [PostViewModel]) {
        viewController?.displayPosts(posts: posts)
    }
    
    func loadCurrentUserData(user: UserDataViewModel) {
        viewController?.loadCurrentUserData(user: user)
    }
    
    func searchPressed() {
        coordinator.searchPressed()
    }
}
