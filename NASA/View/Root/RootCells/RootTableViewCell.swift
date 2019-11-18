import UIKit
import SnapKit
import Kingfisher

class RootTableViewCell: UITableViewCell {
    
    static let reuseID = String(describing: RootTableViewCell.self)
    
    private let backView: UIView = {
        let v = UIView()
        v.backgroundColor = .backgroundTheme
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOffset = CGSize.zero
        v.layer.shadowOpacity = 0.2
        v.layer.shadowRadius = 6.0
        v.layer.masksToBounds = false
        v.layer.cornerRadius = 16
        return v
    }()
    
    private let imageV: UIImageView = {
        let imgV = UIImageView()
        imgV.contentMode = .scaleAspectFill
        imgV.backgroundColor = .clear
        imgV.layer.cornerRadius = 16
        imgV.layer.masksToBounds = true
        return imgV
    }()
    
    private let label: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Helvetica-Bold", size: 16)
        lbl.textColor = .white
        lbl.shadowColor = .black
        lbl.shadowOffset = CGSize(width: 1, height: 1)
        lbl.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        lbl.textAlignment = .center
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 2
        lbl.layer.cornerRadius = 16
        lbl.layer.masksToBounds = true
        return lbl
    }()

    func configure(item: Item) {
        imageV.kf.indicatorType = .activity
        imageV.kf.setImage(with: URL(string: item.pic))
        label.text = item.title
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

private extension RootTableViewCell {
    
    func setupView() {
        self.backgroundColor = .clear
                
        self.addSubview(backView)
        backView.addSubviews([imageV, label])
        
        let offset: CGFloat = 5
        
        backView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(offset)
        }
        
        imageV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
