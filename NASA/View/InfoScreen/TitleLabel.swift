import UIKit

class TitleLabel: UILabel {
    
    private var fromColor: UIColor = .white
    private var toColor: UIColor = .black

    convenience init(_ from: UIColor, _ to: UIColor) {
        self.init(frame: .zero)
        fromColor = from
        toColor = to
    }
    
    override public class var layerClass: AnyClass { CAGradientLayer.self }
    
    var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateLocations()
        updateColors()
    }

}


private extension TitleLabel {
    
    func updateLocations() {
        gradientLayer.locations = [0.0, 1.0]
    }
    
    func updateColors() {
        gradientLayer.colors = [fromColor.cgColor, toColor.cgColor]
    }
    
}
