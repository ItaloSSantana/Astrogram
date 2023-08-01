import Foundation

protocol EditProfilePresenting: AnyObject {
    func loadUserData(viewModel: UserDataViewModel)
    func returnPressed()
    func saveChanges()
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
 
    func returnPressed() {
        coordinator.returnPressed()
    }
    
    func saveChanges() {
        coordinator.returnPressed()
    }
}
