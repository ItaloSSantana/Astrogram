import UIKit

protocol SearchDelegate {
    func continueFlow()
}

protocol SearchCoordinating: AnyObject {
    var viewController: UIViewController? {get set}
    func continueFlow()
}

final class SearchCoordinator: SearchCoordinating {
    private var delegate: SearchDelegate
    var viewController: UIViewController?
    
    init(delegate: SearchDelegate) {
        self.delegate = delegate
    }
    
    func continueFlow() {
        // :- NEXT PR
    }
}
