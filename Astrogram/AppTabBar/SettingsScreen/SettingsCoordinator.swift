import UIKit

protocol SettingsDelegate {
    func editProfilePressed(viewModel: UserDataViewModel)
    func logoutPressed()
}

protocol SettingsCoordinating: AnyObject {
    var viewController: UIViewController? {get set}
    func editProfilePressed(viewModel: UserDataViewModel)
    func logoutPressed()
}

final class SettingsCoordinator: SettingsCoordinating {
    private var delegate: SettingsDelegate
    var viewController: UIViewController?
    
    init(delegate: SettingsDelegate) {
        self.delegate = delegate
    }
   
    func editProfilePressed(viewModel: UserDataViewModel) {
        delegate.editProfilePressed(viewModel: viewModel)
    }
    
    func logoutPressed() {
        delegate.logoutPressed()
    }
}
