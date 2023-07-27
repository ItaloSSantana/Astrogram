import UIKit

protocol AddPostDisplaying: AnyObject {
    func doSomething()
}

final class AddPostController: ViewController<AddPostInteracting, UIView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}

extension AddPostController: AddPostDisplaying {
    func doSomething() {
        //
    }
}
