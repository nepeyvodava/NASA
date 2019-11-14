import UIKit

class RootViewController: UITableViewController {
    
    var data = ["1 - qweqw", "2 - qweqweqweqq", "3 - dsdsc"]
    
    let rawHeight: CGFloat = 60

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        self.view.backgroundColor = .red
    }
    
    //MARK: - Table DataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let toVC = InfoViewController()
        toVC.title = data[indexPath.row]
        self.navigationController?.pushViewController(toVC, animated: true)
    }
    
    //MARK: - Table Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rawHeight
    }
    
}

