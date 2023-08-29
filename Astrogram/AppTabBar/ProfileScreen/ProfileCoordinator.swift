import UIKit

protocol ProfileDelegate {
    func returnPressed()
}

protocol ProfileCoordinating: AnyObject {
    var viewController: UIViewController? {get set}
    func returnPressed()
}

final class ProfileCoordinator: ProfileCoordinating {
    private var delegate: ProfileDelegate
    var viewController: UIViewController?
    
    init(delegate: ProfileDelegate) {
        self.delegate = delegate
    }
    
    func returnPressed() {
        delegate.returnPressed()
    }
}
