import UIKit

class FooterRoot: UITableViewHeaderFooterView {

    static let reuseID = String(describing: FooterRoot.self)
    
    private let label: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Helvetica", size: 26)
        lbl.textColor = .red
        lbl.textAlignment = .center
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 2
        return lbl
    }()
    
    func configure(title: String?) {
        label.text = title
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
}


private extension FooterRoot {
    
    func setupView() {
        addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
