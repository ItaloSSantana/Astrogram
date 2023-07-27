import UIKit

protocol ProfileDelegate {
    func continueFlow()
}

protocol ProfileCoordinating: AnyObject {
    var viewController: UIViewController? {get set}
    func continueFlow()
}

final class ProfileCoordinator: ProfileCoordinating {
    private var delegate: ProfileDelegate
    var viewController: UIViewController?
    
    init(delegate: ProfileDelegate) {
        self.delegate = delegate
    }
    
    func continueFlow() {
        // :- NEXT PR
    }
}
