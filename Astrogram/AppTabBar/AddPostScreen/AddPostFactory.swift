import UIKit

enum AddPostFactory {
    static func make(delegate: AddPostDelegate) -> UIViewController {
        let coordinator = AddPostCoordinator(delegate: delegate)
        let presenter = AddPostPresenter(coordinator: coordinator)
        let interactor = AddPostInteractor(presenter: presenter)
        let controller = AddPostController(interactor: interactor)
        presenter.viewController = controller
        coordinator.viewController = controller
        return controller
    }
}
