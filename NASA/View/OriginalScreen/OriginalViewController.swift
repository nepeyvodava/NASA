import UIKit
import Kingfisher

class OriginalViewController: UIViewController {
    
    let provider = Network.provider
    
    let imageV = ZoomImageView()

    private let closeBtn: ConvenientButton = {
        let btn = ConvenientButton()
        btn.setImage(UIImage(named: "cross_btn"), for: .normal)
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(closeBtnPressed(_:)), for: .touchUpInside)
        return btn
    }()
    
    func configure(id: String, placeholder: UIImage) {
        imageV.imageView.image = placeholder
        provider.request(.fetchPhoto(id: id)) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                do {
                    let collection = try JSONDecoder().decode(PhotoResponse.self, from: response.data)
                    let pic = collection.original
                    self.imageV.imageView.kf.indicatorType = .activity
                    self.imageV.imageView.kf.setImage(with: URL(string: pic), placeholder: placeholder)
                } catch(let error) {
                    self.showAlert(error: error)
                }
            case .failure(let error):
                self.showAlert(error: error)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        imageV.setZoomScale(1, animated: true)
    }
    
}


private extension OriginalViewController {
    
    func setupView() {
        view.backgroundColor = .black
        view.addSubviews([imageV, closeBtn])
        
        imageV.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.edges.equalToSuperview()
        }
        
        closeBtn.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(10)
            make.height.width.equalTo(20)
        }
    }
    
    @objc func closeBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
