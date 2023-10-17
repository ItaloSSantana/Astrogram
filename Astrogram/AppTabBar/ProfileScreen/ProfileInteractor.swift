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
    func addFollowUser()
    func validateFollower()
    func validateFollowing()
    func validatePosts()
}

final class ProfileInteractor: ProfileInteracting {

    
    let presenter: ProfilePresenting
    
    private var auth: Auth?
    private var userID = ""
    private var currentID = ""
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
                if let currentID = auth?.currentUser?.uid {
                    self.currentID = currentID
                }
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
    
    func addFollowUser() {
        let followedDB = db?.collection("following").document(self.userID).collection("isFollowed").document(self.currentID)
        let followsDB = db?.collection("followers").document(self.currentID).collection("follows").document(self.userID)
        followsDB?.getDocument(completion: { (snapshot, error) in
            if let safeSnap = snapshot?.data() {
                followedDB?.delete()
                followsDB?.delete()
            } else {
                followedDB?.setData(["id":self.currentID])
                followsDB?.setData(["id":self.userID])
            }
        })
    }
    
    func validateFollower() {
        let followsDB = db?.collection("followers").document(self.currentID).collection("follows").document(self.userID)
        followsDB?.addSnapshotListener({ (snapshot, error) in
            guard let safeSnap = snapshot?.data() else { return }
            print(safeSnap.count)
            self.presenter.validadeFollowerCount(validate: safeSnap.count)
        })
    
        
    }
    func validateFollowing() {
        let followedDB = db?.collection("following").document(self.userID).collection("isFollowed").document(self.currentID)
        followedDB?.addSnapshotListener({ (snapshot, error) in
            guard let safeSnap = snapshot?.data() else { return }
            print(safeSnap.count)
            self.presenter.validadeFollowingCount(validate: safeSnap.count)
        })
        
    }
    
    func validatePosts() {
        var postsCount = 0
        db?.collection("posts").getDocuments(completion: { (snapshot, error) in
            guard let posts = snapshot?.documents else { return }
            posts.forEach { (post) in
                if post["userID"] as? String == self.userID {
                    postsCount += 1
                    print(postsCount)
                }
            }
            self.presenter.validatePostCount(validate: postsCount)
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
