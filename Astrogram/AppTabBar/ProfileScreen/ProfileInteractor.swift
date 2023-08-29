import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage

protocol ProfileInteracting: AnyObject {
    func loadData()
    func continueFlow()
    func validateCurrentUser()
    func returnPressed()
}

final class ProfileInteractor: ProfileInteracting {

    
    let presenter: ProfilePresenting
    
    private var auth: Auth?
    private var userID = ""
    private var db: Firestore?
    private var storage: Storage?
    private var postList: [PostViewModel] = []
    private var messageListener: ListenerRegistration?
    private var isCurrentUser: Bool = false
    
    init(presenter: ProfilePresenting, isCurrentUser: Bool, userData: UserDataViewModel?) {
        self.presenter = presenter
        auth = Auth.auth()
        db = Firestore.firestore()
        storage = Storage.storage()
        
        self.isCurrentUser = isCurrentUser
        
        if isCurrentUser == true {
            if let id = auth?.currentUser?.uid {
                userID = id
            }
        } else {
            if let id = userData?.id {
                userID = id
            }
        }
    }
    
    func loadData() {
        db?.collection("users").document(userID).getDocument(completion: { (document, error) in
            guard let safeData = document?.data(),
                  let safeName = safeData["name"] as? String,
                  let safeEmail = safeData["email"] as? String,
                  let safeNick = safeData["nickName"] as? String,
                  let safeID = safeData["id"] as? String,
                  let safeUserImage = safeData["profileImage"] as? String else { return }
            self.db?.collection("posts").getDocuments(completion: { (posts, error) in
                guard let safePosts = posts?.documents else { return }
                safePosts.forEach { (post) in
                    if post["userID"] as? String == self.userID {
                        guard let safeImage = post["imageURL"] as? String,
                              let safeText = post["text"] as? String else { return }
                        self.postList.append(PostViewModel(text: safeText, imageURL: safeImage, userID: self.userID, userImage: safeUserImage))
                    }
                }
                self.presenter.displayScreen(user: UserDataViewModel(name: safeName, nick: safeNick, email: safeEmail, image: safeUserImage, id: safeID),
                                             posts: self.postList)
            })
        })
    }
    
    func validateCurrentUser() {
        if isCurrentUser {
            presenter.validateUser(validate: true)
        } else {
            presenter.validateUser(validate: false)
        }
    }
    
    func returnPressed() {
        presenter.returnPressed()
    }

    func continueFlow() {
        // :- NEXT PR
    }
}
