import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage

protocol HomeInteracting: AnyObject {
    func loadData()
    func searchPressed()
    func loadCurrentUserData()
}

final class HomeInteractor: HomeInteracting {
    let presenter: HomePresenting
    
    private var auth: Auth?
    private var userID = ""
    private var db: Firestore?
    private var storage: Storage?
    private var posts: [PostViewModel] = []
    private var followingPosts: [PostViewModel] = []
    private var showPosts: [PostViewModel] = []
    
    init(presenter: HomePresenting) {
        self.presenter = presenter
        auth = Auth.auth()
        db = Firestore.firestore()
        storage = Storage.storage()
        
        if let id = auth?.currentUser?.uid {
            userID = id
        }
        
    }

    func loadData() {
        self.db?.collection("posts")
            .order(by: "date", descending: true)
            .getDocuments(completion: { (snapShot, error) in
                guard let safeShot = snapShot else { return }
                safeShot.documents.forEach { (documents) in
                    let data = documents.data()
                    guard let safeText = data["text"] as? String,
                          let safeImage = data["imageURL"] as? String,
                          let safeID = data["userID"] as? String else {return}
                    self.posts.append(PostViewModel(text: safeText, imageURL: safeImage, userID: safeID, userImage: "", name: ""))
                }
                self.loadFollowingData { (result) in
                    if result {
                        self.presenter.displayScreen(posts: self.showPosts)
                    }
                }
            })
    }
    
    private func loadFollowingData(completionHandler:@escaping (Bool) -> ()) {
        var control = 0
        posts.forEach { (post) in
            db?.collection("followers")
                .document(userID)
                .collection("follows")
                .document(post.userID)
                .getDocument(completion: { (document, error) in
                    
                    if let safeDoc = document, safeDoc.exists {
                        self.followingPosts.append(post)
                    }
                    control += 1
                    
                    if control == self.posts.count - 1 {
                        self.loadPostUserData { (result) in
                            if result {
                                completionHandler(true)
                            }
                        }
                    }
                })
        }
    }
    
    private func loadPostUserData(completionHandler:@escaping (Bool) -> ()) {
        var control = 0
        followingPosts.forEach { (post) in
            db?.collection("users")
                .document(post.userID)
                .getDocument(completion: { (document, error) in
                    if let err = error {
                        print(err.localizedDescription)
                    }
                    if let safeDoc = document?.data() {
                        guard let safeImage = safeDoc["profileImage"] as? String,
                              let safeName = safeDoc["name"] as? String else {return}
                        self.showPosts.append(PostViewModel(text: post.text, imageURL: post.imageURL, userID: post.userID, userImage: safeImage, name: safeName))
                    }
                    control += 1
                    if control == self.followingPosts.count - 1 {
                        print(self.showPosts.count)
                        completionHandler(true)
                    }
                })
        }
    }
    
    func loadCurrentUserData() {
        db?.collection("users").document(userID).getDocument(completion: { (document, error) in
            guard let safeData = document?.data(),
                  let safeName = safeData["name"] as? String,
                  let safeEmail = safeData["email"] as? String,
                  let safeNick = safeData["nickName"] as? String,
                  let safeID = safeData["id"] as? String,
                  let safeUserImage = safeData["profileImage"] as? String else { return }
            self.presenter.loadCurrentUserData(user: UserDataViewModel(name: safeName, nick: safeNick, email: safeEmail, image: safeUserImage, id: safeID))
        })
        }
    
    func searchPressed() {
        presenter.searchPressed()
    }
}
