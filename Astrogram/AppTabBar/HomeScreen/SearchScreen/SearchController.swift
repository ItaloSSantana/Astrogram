import UIKit

protocol SearchDisplaying: AnyObject {
    func usersLoaded(users: [UserDataViewModel])
}

final class SearchController: ViewController<SearchInteracting, UIView> {
    private lazy var  backgroundImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constants.Images.settingsBackground)
        return image
    }()
    
    
    private lazy var returnButton: CDefaultButton = {
        let button = CDefaultButton(image: Constants.Images.backIcon,
                                    radius: 23,
                                    color: Constants.Colors.darkColor,
                                    shadow: Constants.Colors.darkColor)
        button.action = {
            self.returnPressed()
        }
        return button
    }()
    
    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.searchBarStyle = UISearchBar.Style.minimal
        search.placeholder = " Pesquisar..."
        search.sizeToFit()
        search.isTranslucent = true
        search.delegate = self
        search.clipsToBounds = true
        search.layer.cornerRadius = 25
        search.backgroundImage = UIImage()
        search.barTintColor = UIColor(hexaRGBA: Constants.Colors.darkColor)
        search.searchTextField.layer.cornerRadius = 20
        search.searchTextField.layer.masksToBounds = true
        return search
    }()
    
    lazy var usersTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 100
        tableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private var usersList: [UserDataViewModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usersTableView.delegate = self
        usersTableView.dataSource = self
        view.backgroundColor = .blue
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        interactor.removeListener()
    }
    
    override func buildViewHierarchy() {
        view.addSubview(backgroundImage)
        view.addSubview(returnButton)
        view.addSubview(searchBar)
        view.addSubview(usersTableView)
    }
    
    override func setupConstraints() {
        backgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        returnButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Space.base00.rawValue)
            $0.leading.equalToSuperview().offset(Space.base04.rawValue)
            $0.width.height.equalTo(45)
        }
        
        searchBar.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Space.none.rawValue)
            $0.leading.equalTo(returnButton.snp.trailing).offset(Space.base01.rawValue)
            $0.trailing.equalToSuperview().offset(-Space.base01.rawValue)
        }
        
        usersTableView.snp.makeConstraints{
            $0.top.equalTo(searchBar.snp.bottom).offset(Space.base02.rawValue)
            $0.leading.trailing.equalToSuperview().inset(Space.none.rawValue)
            $0.bottom.equalToSuperview()
        }
    }
    
    @objc private func returnPressed() {
        interactor.returnPressed()
    }
    
}

extension SearchController: SearchDisplaying {
    func usersLoaded(users: [UserDataViewModel]) {
        usersList = users
        print(usersList.count)
        usersTableView.reloadData()
    }
}

extension SearchController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            interactor.loadData()
            usersTableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let resultText = searchBar.text {
            if resultText != "" {
                interactor.searchPressed(text: resultText)
                usersTableView.reloadData()
            }
        }
    }
}

extension SearchController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as? SearchCell else { return UITableViewCell() }
        let user = usersList[indexPath.row]
        cell.setupCell(user: user)
        return cell
    }
}
