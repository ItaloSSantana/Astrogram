import Foundation

class UserDataViewModel {
    let name: String
    let nick: String
    let email: String
    let image: String
    
    init(name: String, nick: String, email: String, image: String) {
        self.name = name
        self.nick = nick
        self.email = email
        self.image = image
    }
}
