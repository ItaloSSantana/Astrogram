import UIKit

enum HomeViewFactory {
    static func make(delegate: HomeDelegate) -> UIViewController {
        let coordinator = HomeCoordinator(delegate: delegate)
        let presenter = HomePresenter(coordinator: coordinator)
        let interactor = HomeInteractor(presenter: presenter)
        let controller = HomeController(interactor: interactor)
        presenter.viewController = controller
        coordinator.viewController = controller
        return controller
    }
}
