import UIKit

protocol MessagesDisplaying: AnyObject {
    func doSomething()
}

final class MessagesController: ViewController<MessagesInteracting, UIView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}

extension MessagesController: MessagesDisplaying {
    func doSomething() {
        //
    }
}
