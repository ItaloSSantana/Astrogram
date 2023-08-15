import Foundation

protocol HomePresenting: AnyObject {
    func displayScreen(posts: [PostViewModel])
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
    
    func performAction() {
        // :- NEXT PR
    }
}
