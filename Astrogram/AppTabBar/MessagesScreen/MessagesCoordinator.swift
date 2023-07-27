import UIKit

protocol MessagesDelegate {
    func continueFlow()
}

protocol MessagesCoordinating: AnyObject {
    var viewController: UIViewController? {get set}
    func continueFlow()
}

final class MessagesCoordinator: MessagesCoordinating {
    private var delegate: MessagesDelegate
    var viewController: UIViewController?
    
    init(delegate: MessagesDelegate) {
        self.delegate = delegate
    }
    
    func continueFlow() {
        // :- NEXT PR
    }
}
