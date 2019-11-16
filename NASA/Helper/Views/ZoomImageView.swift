import UIKit

class ZoomImageView: UIScrollView {
    
    let imageView: UIImageView = {
        let imgV = UIImageView()
        imgV.contentMode = .scaleAspectFit
        imgV.backgroundColor = .black
        return imgV
    }()
    
    convenience init() {
        self.init(frame: .zero)
        setupView()
    }
    
}


extension ZoomImageView: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}


private extension ZoomImageView {
    
    func setupView() {
        backgroundColor = .clear
        
        delegate = self
        minimumZoomScale = 1.0
        maximumZoomScale = 10.0
        
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.edges.equalToSuperview()
        }
    }
    
}
