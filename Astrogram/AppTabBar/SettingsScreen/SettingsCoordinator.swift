import UIKit

protocol SettingsDelegate {
    func editProfilePressed()
    func logoutPressed()
}

protocol SettingsCoordinating: AnyObject {
    var viewController: UIViewController? {get set}
    func editProfilePressed()
    func logoutPressed()
}

final class SettingsCoordinator: SettingsCoordinating {
    private var delegate: SettingsDelegate
    var viewController: UIViewController?
    
    init(delegate: SettingsDelegate) {
        self.delegate = delegate
    }
   
    func editProfilePressed() {
        delegate.editProfilePressed()
    }
    
    func logoutPressed() {
        delegate.logoutPressed()
    }
}
