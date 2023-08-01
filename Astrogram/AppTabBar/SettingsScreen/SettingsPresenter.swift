import Foundation

protocol SettingsPresenting: AnyObject {
    func editProfilePressed()
    func logoutPressed()
    func loadUserData(data: UserDataViewModel)
}

final class SettingsPresenter: SettingsPresenting {
    weak var viewController: SettingsDisplaying?
    private let coordinator: SettingsCoordinating
    
    init(coordinator: SettingsCoordinating) {
        self.coordinator = coordinator
    }
    
    func loadUserData(data: UserDataViewModel) {
        viewController?.loadUserData(data: data)
    }
    
    func performAction() {
        // :- NEXT PR
    }
    
    func editProfilePressed() {
        coordinator.editProfilePressed()
    }
    
    func logoutPressed() {
        coordinator.logoutPressed()
    }
}
    
