import UIKit

protocol AddPostDisplaying: AnyObject {
    func doSomething()
}

final class AddPostController: ViewController<AddPostInteracting, UIView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

extension AddPostController: AddPostDisplaying {
    func doSomething() {
        //
    }
}
