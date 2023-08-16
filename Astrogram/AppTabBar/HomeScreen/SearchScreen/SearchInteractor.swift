import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage

protocol SearchInteracting: AnyObject {
    func loadData()
    func returnPressed()
}

final class SearchInteractor: SearchInteracting {
    let presenter: SearchPresenting
    
    private var auth: Auth?
    private var userID = ""
    private var db: Firestore?
    private var storage: Storage?
    private var userList: [UserDataViewModel] = []
    
    init(presenter: SearchPresenting) {
        self.presenter = presenter
        auth = Auth.auth()
        db = Firestore.firestore()
        storage = Storage.storage()
    }
    
    func loadData() {
        let usersRef = db?.collection("users").getDocuments(completion: { (snapshot, error) in
            guard let safeSnap = snapshot?.documents else { return }
            safeSnap.forEach { (document) in
                guard let safeName = document["name"] as? String,
                      let safeNick = document["nickName"] as? String,
                      let safePicture = document["profileImage"] as? String,
                      let safeEmail = document ["email"] as? String else { return }
                self.userList.append(UserDataViewModel(name: safeName, nick: safeNick, email: safeEmail , image: safePicture))
            }
            self.presenter.displayScreen(users: self.userList)
        })
    }
    
    func returnPressed() {
        presenter.returnPressed()
    }
}
