import UIKit

class ConvenientButton: UIButton {
    
    var offset: CGFloat = 10

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let newArea = CGRect(x: self.bounds.origin.x - offset,
                              y: self.bounds.origin.y - offset,
                              width: self.bounds.width + offset*2,
                              height: self.bounds.height + offset*2)
        return newArea.contains(point)
    }

}
