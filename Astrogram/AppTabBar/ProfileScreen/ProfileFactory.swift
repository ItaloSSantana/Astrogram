import UIKit

enum ProfileFactory {
    static func make(delegate: ProfileDelegate, isCurrentUser: Bool, userData: UserDataViewModel?) -> UIViewController {
        let coordinator = ProfileCoordinator(delegate: delegate)
        let presenter = ProfilePresenter(coordinator: coordinator)
        let interactor = ProfileInteractor(presenter: presenter, isCurrentUser: isCurrentUser, userData: userData)
        let controller = ProfileController(interactor: interactor)
        presenter.viewController = controller
        coordinator.viewController = controller
        return controller
    }
}
