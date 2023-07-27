import UIKit

protocol SettingsDisplaying: AnyObject {
    func doSomething()
}

final class SettingsController: ViewController<SettingsInteracting, UIView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
    }
}

extension SettingsController: SettingsDisplaying {
    func doSomething() {
        //
    }
}
