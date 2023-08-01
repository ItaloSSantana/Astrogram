import Foundation

protocol EditProfilePresenting: AnyObject {
    func loadUserData(viewModel: UserDataViewModel)
    func returnPressed()
}

final class EditProfilePresenter: EditProfilePresenting {
    weak var viewController: EditProfileDisplaying?
    private let coordinator: EditProfileCoordinating
    
    init(coordinator: EditProfileCoordinating) {
        self.coordinator = coordinator
    }
    
    func loadUserData(viewModel: UserDataViewModel) {
        viewController?.loadUserData(viewModel: viewModel)
    }
    
    func performAction() {
        // :- NEXT PR
    }
    
    func returnPressed() {
        coordinator.returnPressed()
    }
}
