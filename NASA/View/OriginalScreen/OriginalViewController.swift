import UIKit
import Kingfisher

class OriginalViewController: ScrollViewController {
    
    let provider = Network.provider
    
    let imageV: UIImageView = {
        let imgV = UIImageView()
        imgV.contentMode = .scaleAspectFit
        imgV.backgroundColor = .black
        return imgV
    }()

    private let closeBtn: ConvenientButton = {
        let btn = ConvenientButton()
        btn.setImage(UIImage(named: "cross_btn"), for: .normal)
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(closeBtnPressed(_:)), for: .touchUpInside)
        return btn
    }()
    
    func configure(id: String) {
        provider.request(.fetchPhoto(id: id)) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                do {
                    let collection = try JSONDecoder().decode(PhotoResponse.self, from: response.data)
                    let pic = collection.original
                    self.imageV.kf.indicatorType = .activity
                    self.imageV.kf.setImage(with: URL(string: pic))
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

}


extension OriginalViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageV
    }
    
}


private extension OriginalViewController {
    
    func setupView() {
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 10.0
        scrollView.backgroundColor = .black
        
//        scrollView.alwaysBounceVertical = false
//        scrollView.alwaysBounceHorizontal = false
//        scrollView.showsVerticalScrollIndicator = true
//        scrollView.flashScrollIndicators()
        
        view.backgroundColor = .black
        view.addSubview(closeBtn)
        
        closeBtn.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(10)
            make.height.width.equalTo(20)
        }
        
        contentView.addSubview(imageV)
//        scrollView.addSubview(imageV)
        
        imageV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(Assets.screenHeight)
            make.width.equalTo(Assets.screenWidth)
        }
    }
    
    @objc func closeBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
