import UIKit

class AppTabBar: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let homeController = HomeViewFactory.make(delegate: self)
        homeController.tabBarController?.navigationItem.title = "Home"
        
        let profileController = ProfileFactory.make(delegate: self)
        profileController.tabBarController?.navigationItem.title = "Profile"
        
        let addPostController = AddPostFactory.make(delegate: self)
        addPostController.tabBarController?.navigationItem.title = "Add"
        
        let messagesController = MessagesFactory.make(delegate: self)
        messagesController.tabBarController?.navigationItem.title = "Messages"
        
        let settingsController = SettingsFactory.make(delegate: self)
        settingsController.tabBarController?.navigationItem.title = "Settings"
        
        let tabBarAppearence = UITabBarAppearance()
        tabBarAppearence.backgroundColor = .white
        tabBarAppearence.configureWithTransparentBackground()
        tabBarItem.standardAppearance = tabBarAppearence
        self.setViewControllers([homeController,profileController,addPostController,messagesController,settingsController], animated: true)
        self.tabBar.tintColor = UIColor(hexaRGBA: Constants.Colors.blackColor)
        
     //   setupItems()
    }
    
//    func setupItems() {
//          guard var items = self.tabBar.items else {return}
//        let images = [Constants.Images.messages,Constants.Images.contacts, Constants.Images.settings]
//
//          for x in 0...2 {
//            items[x].image = UIImage(named: images[x])?.withRenderingMode(.automatic)
//          }
//      }
}

extension AppTabBar: HomeDelegate {
    func continueFlow() {
        //
    }
}

extension AppTabBar: ProfileDelegate {
    
}

extension AppTabBar: AddPostDelegate {
    
}

extension AppTabBar: MessagesDelegate {
    
}

extension AppTabBar: SettingsDelegate {
    
}
