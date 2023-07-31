import UIKit

protocol SettingsDelegate {
    func continueFlow()
}

protocol SettingsCoordinating: AnyObject {
    var viewController: UIViewController? {get set}
    func continueFlow()
}

final class SettingsCoordinator: SettingsCoordinating {
    private var delegate: SettingsDelegate
    var viewController: UIViewController?
    
    init(delegate: SettingsDelegate) {
        self.delegate = delegate
    }
    
    func continueFlow() {
        // :- NEXT PR
    }
}
