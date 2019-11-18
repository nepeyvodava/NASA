import UIKit

class InfoViewController: UIViewController {
    
    //MARK: - Variables
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
        lbl.font = UIFont(name: "Helvetica-Bold", size: 16)
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
        imgV.backgroundColor = .black
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
        txtV.font = UIFont(name: "Helvetica", size: 16)
        txtV.isEditable = false
        return txtV
    }()
    
    func configure(item: Item) {
        label.text = item.title
        imageV.kf.setImage(with: URL(string: item.pic))
        info.text = item.description
        self.item = item
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
}


//MARK: - Actions
private extension InfoViewController {
    
    @objc func closeBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func imageBtnPressed(_ sender: UIButton) {
        guard let id = self.item?.nasa_id else { return }
        let placeholder = imageV.image ?? UIImage()
        let originalVC = OriginalViewController()
        originalVC.configure(id: id, placeholder: placeholder)
        originalVC.modalPresentationStyle = .fullScreen
        originalVC.modalTransitionStyle = .crossDissolve
        
        let scale = imageScale(for: imageV.image, inImageViewAspectFill: imageV)

        UIView.animate(withDuration: 1.0, animations: {
            self.imageV.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2 - 20)
            self.imageV.transform = CGAffineTransform(scaleX: scale, y: scale)
            self.label.transform = CGAffineTransform(translationX: 0, y: self.label.frame.height)
            self.closeBtn.transform = CGAffineTransform(translationX: 0, y: -self.closeBtn.frame.height*2)
            self.line.transform = CGAffineTransform(translationX: 0, y: -self.line.frame.height*3)
            self.info.alpha = 0
            self.view.backgroundColor = .clear
        }) { _ in
            self.present(originalVC, animated: true) {
                self.imageV.transform = .identity
                self.label.transform = .identity
                self.closeBtn.transform = .identity
                self.line.transform = .identity
                self.info.alpha = 1
            }
        }
    }
    
    func imageScale(for image: UIImage?, inImageViewAspectFill imageView: UIImageView?) -> CGFloat {
        guard let image = image, let imageView = imageView else { return 0 }
        if Assets.isPortrait {
            let imageRatio = image.size.width / image.size.height
            let viewRatio = imageView.frame.width / imageView.frame.height
            if imageRatio < viewRatio { return 1.0 } else { return (viewRatio / imageRatio) }
        } else {
            let imageRatio = image.size.width / image.size.height
            let viewRatio = Assets.screenWidth / Assets.screenHeight
            if imageRatio > viewRatio { return 1.0 } else { return (imageRatio / viewRatio) }
        }
    }
    
}


//MARK: - setup
private extension InfoViewController {
        
    func setupView() {
        view.backgroundColor = .groupTableViewBackground
        title = "Details"
        imageV.addSubviews([imageButton, label])
        view.addSubviews([info, imageV, line, closeBtn])
        
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
            make.height.equalToSuperview().multipliedBy(0.4)
        }
        
        imageButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        info.snp.makeConstraints { make in
            make.top.equalTo(imageV.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
    }
    
}
