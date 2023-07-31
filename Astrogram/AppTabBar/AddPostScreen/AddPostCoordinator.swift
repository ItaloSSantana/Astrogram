import UIKit

protocol AddPostDelegate {
    func continueFlow()
}

protocol AddPostCoordinating: AnyObject {
    var viewController: UIViewController? {get set}
    func continueFlow()
}

final class AddPostCoordinator: AddPostCoordinating {
    private var delegate: AddPostDelegate
    var viewController: UIViewController?
    
    init(delegate: AddPostDelegate) {
        self.delegate = delegate
    }
    
    func continueFlow() {
        // :- NEXT PR
    }
}
