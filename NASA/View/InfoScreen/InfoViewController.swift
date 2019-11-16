import UIKit

class InfoViewController: UIViewController {
    
    private var item: Item?
    
    private let line: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 3
        v.backgroundColor = .gray
        return v
    }()
    
    private let closeBtn: ConvenientButton = {
        let btn = ConvenientButton()
        btn.setImage(UIImage(named: "cross_btn"), for: .normal)
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(closeBtnPressed(_:)), for: .touchUpInside)
        return btn
    }()

    private let label: TitleLabel = {
        let lbl = TitleLabel(.clear, .black)
        lbl.font = UIFont(name: "Georgia-Bold", size: 16)
        lbl.textColor = .white
        lbl.textAlignment = .left
        lbl.lineBreakMode = .byWordWrapping
        lbl.numberOfLines = 2
        lbl.backgroundColor = .clear
        
        return lbl
    }()
    
    private let imageV: UIImageView = {
        let imgV = UIImageView()
        imgV.contentMode = .scaleAspectFill
        imgV.backgroundColor = .clear
        imgV.layer.masksToBounds = true
        imgV.isUserInteractionEnabled = true
        
        return imgV
    }()
    
    private let imageButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(imageBtnPressed(_:)), for: .touchUpInside)
        return btn
    }()
    
    private let info: UITextView = {
        let txtV = UITextView()
        txtV.isEditable = false
        return txtV
    }()
    
    func configure(item: Item) {
        label.text = item.title
        imageV.kf.setImage(with: URL(string: item.pic))
        info.text = item.description
        self.item = item
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
}


private extension InfoViewController {
    
//    func setupView() {
//        view.backgroundColor = .groupTableViewBackground
//        title = "Details"
//        view.addSubviews([label, imageV, info])
//
//        let offset: CGFloat = 5
//
//        label.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
//            make.left.right.equalToSuperview().inset(offset)
//            make.height.equalTo(40)
//        }
//
//        imageV.snp.makeConstraints { make in
//            make.top.equalTo(label.snp.bottom)
//            make.left.right.equalToSuperview().inset(offset)
//            make.height.equalTo(Assets.screenHeight * 0.4)
//        }
//
//        info.snp.makeConstraints { make in
//            make.top.equalTo(imageV.snp.bottom).offset(offset)
//            make.left.right.bottom.equalToSuperview().inset(offset)
//        }
//    }
    
    func setupView() {
        view.backgroundColor = .groupTableViewBackground
        title = "Details"
        imageV.addSubviews([imageButton, label])
        view.addSubviews([imageV, info, line, closeBtn])
        
        line.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(100)
            make.height.equalTo(6)
        }
        
        closeBtn.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(10)
            make.height.width.equalTo(20)
        }
        
        label.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(40)
        }
        
        imageV.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(Assets.screenHeight * 0.4)
        }
        
        imageButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        info.snp.makeConstraints { make in
            make.top.equalTo(imageV.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
    }
    
    @objc func closeBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func imageBtnPressed(_ sender: UIButton) {
        guard let id = self.item?.nasa_id else { return }
        let originalVC = OriginalViewController()
        originalVC.configure(id: id)
        originalVC.modalPresentationStyle = .fullScreen
        present(originalVC, animated: true, completion: nil)
    }
    
}
