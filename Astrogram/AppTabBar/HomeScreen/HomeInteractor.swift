import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage

protocol HomeInteracting: AnyObject {
    func loadData()
    func continueFlow()
}

final class HomeInteractor: HomeInteracting {
    let presenter: HomePresenting
    
    private var auth: Auth?
    private var userID = ""
    private var db: Firestore?
    private var storage: Storage?
    private var posts: [PostViewModel] = []
    private var followingPosts: [PostViewModel] = []
    
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
            .limit(to: 10)
            .getDocuments(completion: { (snapShot, error) in
                guard let safeShot = snapShot else { return }
                
                safeShot.documents.forEach { (documents) in
                    let data = documents.data()
                    guard let safeText = data["text"] as? String,
                          let safeImage = data["imageURL"] as? String,
                          let safeID = data["userID"] as? String else {return}
                    self.posts.append(PostViewModel(text: safeText, imageURL: safeImage, userID: safeID))
                }
                self.loadFollowingData { (result) in
                    if result {
                        self.presenter.displayScreen(posts: self.followingPosts)
                    }
                }
            })
    }
    
    private func loadFollowingData(completionHandler:@escaping (Bool) -> ()) {
        var control = 0
        posts.forEach { (post) in
            db?.collection("following")
                .document(userID)
                .collection("follows")
                .document(post.userID)
                .getDocument(completion: { (document, error) in
                    
                    if let safeDoc = document, safeDoc.exists {
                        self.followingPosts.append(post)
                    }
                    
                    control += 1
                    
                    if control == self.posts.count - 1 {
                        completionHandler(true)
                    }
                })
        }
    }
    
    func continueFlow() {
        // :- NEXT PR
    }
}
