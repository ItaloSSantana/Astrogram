import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage

protocol AddPostInteracting: AnyObject {
    func loadData()
    func savePost(image: UIImage, text: String)
}

final class AddPostInteractor: AddPostInteracting {
    let presenter: AddPostPresenting
    
    private var auth: Auth?
    private var userID = ""
    private var db: Firestore?
    private var storage: Storage?
    
    init(presenter: AddPostPresenting) {
        self.presenter = presenter
        
        auth = Auth.auth()
        db = Firestore.firestore()
        storage = Storage.storage()
        
        if let id = auth?.currentUser?.uid {
            self.userID = id
        }
    }
    
    func loadData() {
        //
    }
    
    func savePost(image: UIImage, text: String) {
        let images = storage?.reference().child("images")
        guard let uploadImage = image.jpegData(compressionQuality: 0.3) else {return}
        guard let userID = auth?.currentUser?.uid else {return}
        let uniqueID = UUID().uuidString
        let imageName = ("\(uniqueID).jpg")
        guard let profileImageRef = images?.child("posts").child(imageName) else {
            print("here")
            return}
        
        profileImageRef.putData(uploadImage, metadata: nil, completion: { (metaData, error) in
            if error == nil {
                profileImageRef.downloadURL { url, error in
                    guard let imageUrl = url?.absoluteString else {return}
                    self.db?.collection("posts")
                        .document(userID)
                        .collection("userPosts")
                        .addDocument(data: ["imageURL": imageUrl, "text": text])
                }
            }
        })
        presenter.savePost()
    }
}


