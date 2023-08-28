import Foundation

protocol SearchPresenting: AnyObject {
    func displayScreen(users: [UserDataViewModel])
    func userPressed(user: UserDataViewModel)
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
    
    func userPressed(user: UserDataViewModel) {
        coordinator.userPressed(user: user)
    }
    
    func returnPressed() {
        coordinator.returnPressed()
    }
}
