import UIKit

protocol SearchDisplaying: AnyObject {
    func doSomething()
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
        tableView.rowHeight = 80
        tableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.identifier)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usersTableView.delegate = self
        usersTableView.dataSource = self
        view.backgroundColor = .blue
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
}

extension SearchController: SearchDisplaying {
    func doSomething() {
        //
    }
}

extension SearchController: UISearchBarDelegate {
    
}

extension SearchController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as? SearchCell else { return UITableViewCell() }
        return cell
    }
    
    
}
