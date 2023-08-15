import UIKit

enum SearchFactory {
    static func make(delegate: SearchDelegate) -> UIViewController {
        let coordinator = SearchCoordinator(delegate: delegate)
        let presenter = SearchPresenter(coordinator: coordinator)
        let interactor = SearchInteractor(presenter: presenter)
        let controller = SearchController(interactor: interactor)
        presenter.viewController = controller
        coordinator.viewController = controller
        return controller
    }
}
