import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage

protocol SearchInteracting: AnyObject {
    func loadData()
    func returnPressed()
    func searchPressed(text: String)
    func removeListener()
}

final class SearchInteractor: SearchInteracting {
    let presenter: SearchPresenting
    
    private var auth: Auth?
    private var userID = ""
    private var db: Firestore?
    private var storage: Storage?
    private var userList: [UserDataViewModel] = []
    private var messageListener: ListenerRegistration?
    
    init(presenter: SearchPresenting) {
        self.presenter = presenter
        auth = Auth.auth()
        db = Firestore.firestore()
        storage = Storage.storage()
    }
    
    func loadData() {
        let usersRef = db?.collection("users").addSnapshotListener({ (snapshot, error) in
            guard let safeSnap = snapshot?.documents else { return }
            self.userList.removeAll()
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
    
    func searchPressed(text: String) {
           let filterList = userList
           self.userList.removeAll()
           filterList.forEach { (item) in
               if item.name.lowercased().contains(text.lowercased()) {
                   self.userList.append(item)
               }
           }
        
        self.presenter.displayScreen(users: self.userList)
       }
    
    func returnPressed() {
        presenter.returnPressed()
    }
    
    func removeListener() {
            messageListener?.remove()
        }
}
