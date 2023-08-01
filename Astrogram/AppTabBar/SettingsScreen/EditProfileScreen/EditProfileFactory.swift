import UIKit

enum EditProfileFactory {
    static func make(delegate: EditProfileDelegate, viewModel: UserDataViewModel) -> UIViewController {
        let coordinator = EditProfileCoordinator(delegate: delegate)
        let presenter = EditProfilePresenter(coordinator: coordinator)
        let interactor = EditProfileInteractor(presenter: presenter, viewModel: viewModel)
        let controller = EditProfileController(interactor: interactor)
        presenter.viewController = controller
        coordinator.viewController = controller
        return controller
    }
}
