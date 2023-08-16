import Foundation

protocol SearchPresenting: AnyObject {
    func displayScreen(users: [UserDataViewModel])
    func returnPressed()
}

final class SearchPresenter: SearchPresenting {
    weak var viewController: SearchDisplaying?
    private let coordinator: SearchCoordinating
    
    init(coordinator: SearchCoordinating) {
        self.coordinator = coordinator
    }
    
    func displayScreen(users: [UserDataViewModel]) {
        viewController?.usersLoaded(users: users)
    }
    
    func returnPressed() {
        coordinator.returnPressed()
    }
}
