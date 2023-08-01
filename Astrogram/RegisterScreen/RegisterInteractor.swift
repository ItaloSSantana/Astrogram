import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

protocol RegisterInteracting: AnyObject {
    func registerUser(name: String?, nick: String?, email: String?, password: String?, confirm: String?, check: Bool)
    func confirmTermsPressed(check: Bool)
    func returnPressed()
}

final class RegisterInteractor: RegisterInteracting {
    private let presenter: RegisterPresenting
    
    private var auth: Auth?
    private  var db:Firestore?
    
    init(presenter: RegisterPresenting) {
        self.presenter = presenter
        
        auth = Auth.auth()
        db = Firestore.firestore()
    }
    
    func confirmTermsPressed(check: Bool) {
        var validate = false
        if check == true {
            validate = false
        } else {
            validate = true
        }
        presenter.confirmTermsPressed(check: validate)
    }
    
    func registerUser(name: String?, nick: String?, email: String?, password: String?, confirm: String?, check: Bool) {
        guard check == true else {
            print("you have to agree with terms")
            return
        }
        guard let safeName = name,
              let safeNick = nick,
              let safeEmail = email,
              let safePass = password,
              confirm == password else {return}
        auth?.createUser(withEmail: safeEmail, password: safePass, completion: { (result, error) in
            guard let safeUID = result?.user.uid else {return}
            let imageURL = "https://firebasestorage.googleapis.com/v0/b/astrogram-5c6e2.appspot.com/o/images%2Fprofile%2FprofilePicture.png?alt=media&token=675c391e-5da2-4792-a8c2-294c82b40f0d"
            self.db?.collection("users")
                .document(safeUID)
                .setData(["name": safeName,
                          "nickName": safeNick,
                          "email": safeEmail,
                          "profileImage": imageURL])
            self.presenter.displayScreen()
        })
    }
    
    func returnPressed() {
        presenter.returnPressed()
    }
}
