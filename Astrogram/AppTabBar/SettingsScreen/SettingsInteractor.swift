import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage

protocol SettingsInteracting: AnyObject {
    func loadData()
    func editProfilePressed(viewModel: UserDataViewModel)
    func logoutPressed()
    func removeListener()
}

final class SettingsInteractor: SettingsInteracting {
    let presenter: SettingsPresenting
    let authView = AuthenticationViewModel()
    
    private var auth: Auth?
    private var userID = ""
    private var db: Firestore?
    private var storage: Storage?
    private var listener: ListenerRegistration?
    
    init(presenter: SettingsPresenting) {
        self.presenter = presenter
        auth = Auth.auth()
        db = Firestore.firestore()
        storage = Storage.storage()
        
        if let id = auth?.currentUser?.uid {
            userID = id
        }
    }
    
    func loadData() {
        let userRef = db?.collection("users").document(userID)
        listener = userRef?.addSnapshotListener({ (snapshot, error) in
            guard let safeData = snapshot?.data(),
                  let safeName = safeData["name"] as? String,
                  let safeNick = safeData["nickName"] as? String,
                  let safeEmail = safeData["email"] as? String,
                  let safeImage = safeData["profileImage"] as? String else {return}
            self.presenter.loadUserData(data: UserDataViewModel(name: safeName, nick: safeNick, email: safeEmail, image: safeImage))
        })
    }
    
    func editProfilePressed(viewModel: UserDataViewModel) {
        presenter.editProfilePressed(viewModel: viewModel)
    }
    
    private func loadUserData() {
        
    }
    
    func logoutPressed() {
        authView.signOut()
        presenter.logoutPressed()
    }
    
    func removeListener() {
        listener?.remove()
    }
}

