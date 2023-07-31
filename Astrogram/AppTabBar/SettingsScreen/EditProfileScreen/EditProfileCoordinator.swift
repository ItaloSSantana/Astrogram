import UIKit

protocol EditProfileDelegate {
    func continueFlow()
    func returnPressed()
}

protocol EditProfileCoordinating: AnyObject {
    var viewController: UIViewController? {get set}
    func continueFlow()
    func returnPressed()
}

final class EditProfileCoordinator: EditProfileCoordinating {
    private var delegate: EditProfileDelegate
    var viewController: UIViewController?
    
    init(delegate: EditProfileDelegate) {
        self.delegate = delegate
    }
    
    func continueFlow() {
        // :- NEXT PR
    }
    
    func returnPressed() {
        delegate.returnPressed()
    }
}
