import UIKit
import Moya
import SwiftyJSON

class RootTableViewController: UITableViewController {
    
    //MARK: - Variables
    private let transitionManager = TransitionManager()
    
    var data = [Item]()
    
    weak var searchBar: UISearchBar?
    
    let provider = Network.provider
    
    let headerHeight: CGFloat = 50
    
    let rawHeight: CGFloat = 80

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
        
    //MARK: - Table DataSource
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderSearch.reuseID) as? HeaderSearch
            else { return UIView(frame: .zero) }
        header.searchBar.delegate = self
        searchBar = header.searchBar
        return header
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard data.isEmpty,
            let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: FooterRoot.reuseID) as? FooterRoot
            else { return UIView(frame: .zero) }
        
        searchBarIsEmpty() ?
            footer.configure(title: "Please, enter query.")
            : footer.configure(title: "Sorry, nothing found. Enter another query.")
        
        return footer
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RootTableViewCell.reuseID,
                                                       for: indexPath) as? RootTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
    
        cell.configure(item: data[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.presentData(row: indexPath.row)
        }
    }
    
    //MARK: - Table Delegate
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return headerHeight
     }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rawHeight
    }
    
}


//MARK: - UISearchBarDelegate
extension RootTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let task = DispatchWorkItem {
            self.searchData(q: searchText)
        }
        GCD.newSearchTask(task)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchText = searchBar.text ?? ""
        let task = DispatchWorkItem {
            self.searchData(q: searchText)
        }
        GCD.newSearchTask(task, 0)
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        GCD.currentSearchTask?.cancel()
        searchBar.text = nil
        searchBar.endEditing(true)
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchBar?.text?.isEmpty ?? true
    }
    
}


//MARK: - Actions
private extension RootTableViewController {
    
    func searchData(q: String) {
        provider.request(.searchPhotos(q: q)) { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                do {
                    let collection = try JSONDecoder().decode(SearchResponse.self, from: response.data)
                    self.data = collection.items
                    self.tableView.reloadData()
                } catch(let error) {
                    self.showAlert(error: error)
                }
            case .failure(let error):
                self.showAlert(error: error)
            }
        }
    }
    
    func presentData(row: Int) {
        self.tableView.endEditing(true)
        let toVC = InfoViewController()
        toVC.configure(item: self.data[row])
        toVC.transitioningDelegate = self.transitionManager
        toVC.modalPresentationStyle = .custom
        self.present(toVC, animated: true, completion: nil)
    }
    
}


//MARK: - setup
private extension RootTableViewController {
    
    func setupView() {
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(HeaderSearch.self, forHeaderFooterViewReuseIdentifier: HeaderSearch.reuseID)
        tableView.register(FooterRoot.self, forHeaderFooterViewReuseIdentifier: FooterRoot.reuseID)
        tableView.register(RootTableViewCell.self, forCellReuseIdentifier: RootTableViewCell.reuseID)
    }
    
}
