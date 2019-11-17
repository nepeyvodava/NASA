import UIKit

class HeaderSearch: UITableViewHeaderFooterView {

    static let reuseID = String(describing: HeaderSearch.self)
    
    let searchBar: UISearchBar = {
        let sBar = UISearchBar()
        sBar.showsCancelButton = true
        sBar.placeholder = "search"
        sBar.tintColor = .red
        return sBar
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
}

 
private extension HeaderSearch {
    
    func setupView() {
        addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        if #available(iOS 13, *)
        {
            let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
            let statusBar = UIView()
            statusBar.backgroundColor = .systemBackground
            addSubview(statusBar)
            statusBar.snp.makeConstraints { make in
                make.height.equalTo(statusBarHeight)
                make.width.centerX.equalToSuperview()
                make.bottom.equalTo(self.snp.top)
            }
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = .white
        }
    }
    
}
