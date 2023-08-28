import Foundation

class UserDataViewModel {
    let name: String
    let nick: String
    let email: String
    let image: String
    let id: String
    
    init(name: String, nick: String, email: String, image: String, id: String) {
        self.name = name
        self.nick = nick
        self.email = email
        self.image = image
        self.id = id
    }
}
