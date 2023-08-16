import Foundation
import FirebaseFirestore
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

class AuthenticationViewModel: ObservableObject {
  enum SignInState {
    case signedIn
    case signedOut
  }
  
  @Published var state: SignInState = .signedOut
  
  func signIn() {
    // 1
    if GIDSignIn.sharedInstance.hasPreviousSignIn() {
      GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
        authenticateUser(for: user, with: error)
      }
    } else {
      // 2
      guard let clientID = FirebaseApp.app()?.options.clientID else { return }
      
      // 3
      let configuration = GIDConfiguration(clientID: clientID)
      
      // 4
      guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
      guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
      
      // 5
      GIDSignIn.sharedInstance.signIn(with: configuration, presenting: rootViewController) { [unowned self] user, error in
        authenticateUser(for: user, with: error)
      }
    }
  }
  
  private func authenticateUser(for user: GIDGoogleUser?, with error: Error?) {
    // 1
    if let error = error {
      print(error.localizedDescription)
      return
    }
    
    // 2
    guard let authentication = user?.authentication, let idToken = authentication.idToken else { return }
    
    let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
    
    let auth = Auth.auth()
    // 3
    auth.signIn(with: credential) { [unowned self] (_, error) in
        if let error = error {
            print(error.localizedDescription)
        } else {
            state = .signedIn
            let db = Firestore.firestore()
            guard let uid = auth.currentUser?.uid else {return}
            db.collection("users")
                .document(uid)
                .getDocument { (result, error) in
                    if let safeResult = result, safeResult.exists {
                        print("user already exists")
                    } else {
                        let imageURL = "https://firebasestorage.googleapis.com/v0/b/astrogram-5c6e2.appspot.com/o/images%2Fprofile%2FprofilePicture.png?alt=media&token=675c391e-5da2-4792-a8c2-294c82b40f0d"
                        db.collection("users")
                            .document(uid)
                            .setData(["name": user?.profile?.name,
                                      "nickName" : user?.profile?.givenName,
                                      "email": user?.profile?.email,
                                      "profileImage": imageURL])
                    }
                }
        }
    }
  }
  
  func signOut() {
    // 1
    GIDSignIn.sharedInstance.signOut()
    
    do {
      // 2
      try Auth.auth().signOut()
      
      state = .signedOut
    } catch {
      print(error.localizedDescription)
    }
  }
}
