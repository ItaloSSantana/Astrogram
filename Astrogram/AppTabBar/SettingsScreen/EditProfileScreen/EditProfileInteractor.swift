import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

protocol EditProfileInteracting: AnyObject {
    func loadUserData()
    func returnPressed()
    func saveChanges(name: String, nick: String, email: String, image: UIImage)
}

final class EditProfileInteractor: EditProfileInteracting {
    let presenter: EditProfilePresenting
    
    private var viewModel: UserDataViewModel
    private var auth: Auth?
    private var db: Firestore?
    private var storage: Storage?
    private var userID: String = ""
    
    init(presenter: EditProfilePresenting, viewModel: UserDataViewModel) {
        self.presenter = presenter
        self.viewModel = viewModel
        
        auth = Auth.auth()
        db = Firestore.firestore()
        storage = Storage.storage()
        
        if let id = auth?.currentUser?.uid {
            self.userID = id
        }
    }
    
    func loadUserData() {
        presenter.loadUserData(viewModel: viewModel)
    }
    
    func returnPressed() {
        presenter.returnPressed()
    }
    
    func saveChanges(name: String, nick: String, email: String, image: UIImage) {
        let currentUser = auth?.currentUser
        if  email != viewModel.email {
            currentUser?.updateEmail(to: email, completion: { error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self.db?.collection("users")
                        .document(self.userID)
                        .updateData(["email" : email])
                }
            })
        }
        if name != viewModel.name, name != "" {
            db?.collection("users")
                .document(self.userID)
                .updateData(["name": name])
        }
        
        if nick != viewModel.nick, nick != "" {
            db?.collection("users")
                .document(self.userID)
                .updateData(["nickName": nick])
        }
        
        changeImage(image: image)
        presenter.saveChanges()
    }
    
    func changeImage(image: UIImage) {
        let images = storage?.reference().child("images")
        guard let uploadImage = image.jpegData(compressionQuality: 0.3) else {return}
        guard let userID = auth?.currentUser?.uid else {return}
        let imageName = ("\(userID).jpg")
        guard let profileImageRef = images?.child("profile").child(imageName) else {return}
        
        profileImageRef.putData(uploadImage, metadata: nil, completion: { (metaData, error) in
            if error == nil {
                profileImageRef.downloadURL { url, error in
                    guard let imageUrl = url?.absoluteString else {return}
                    self.db?.collection("users")
                        .document(userID)
                        .updateData(["profileImage": imageUrl])
                }
            }
        })
    }
}
