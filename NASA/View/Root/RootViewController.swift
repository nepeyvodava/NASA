import UIKit
import Moya
import SwiftyJSON

class RootViewController: UITableViewController {
    
    var data = [Item]()
    
    let provider = Network.provider
    
    let headerHeight: CGFloat = 50
    
    let rawHeight: CGFloat = 80

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchData(q: "")
        setupView()
    }
    
    //MARK: - Table DataSource
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderSearch.reuseID) as? HeaderSearch
            else { return UIView(frame: .zero) }
        header.searchBar.delegate = self
        return header
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
            self.tableView.endEditing(true)
            let toVC = InfoViewController()
            toVC.configure(item: self.data[indexPath.row])
            self.present(toVC, animated: true, completion: nil)
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
extension RootViewController: UISearchBarDelegate {
    
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
    
}

//MARK: - setup
private extension RootViewController {
    
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
            
            //            switch result {
            //            case .success(let response):
            //                let result = try! JSONSerialization.jsonObject(with: response.data, options: .mutableContainers)
            //                print(result)
            //            case .failure(let error):
            //                print(error.localizedDescription)
            //            }
            
            //            switch result {
            //            case .success(let response):
            //                let json = JSON(response.data)
            //                let result = json["collection"]["items"][0]
            //                print(result)
            //            case .failure(let error):
            //                print(error.localizedDescription)
            //            }
            
        }
    }
    
    func setupView() {
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(HeaderSearch.self, forHeaderFooterViewReuseIdentifier: HeaderSearch.reuseID)
        tableView.register(RootTableViewCell.self, forCellReuseIdentifier: RootTableViewCell.reuseID)
    }
    
}
