import Foundation

protocol EditProfileInteracting: AnyObject {
    func loadUserData()
    func returnPressed()
    func saveChanges()
}

final class EditProfileInteractor: EditProfileInteracting {
    let presenter: EditProfilePresenting
    
    private var viewModel: UserDataViewModel
    
    init(presenter: EditProfilePresenting, viewModel: UserDataViewModel) {
        self.presenter = presenter
        self.viewModel = viewModel
    }
    
    func loadUserData() {
        presenter.loadUserData(viewModel: viewModel)
    }
    
    func returnPressed() {
        presenter.returnPressed()
    }
    
    func saveChanges() {
        <#code#>
    }
}
