import UIKit

class Assets {
    
    static var screenWidth: CGFloat { return UIScreen.main.bounds.width }
      
    static var screenHeight: CGFloat { return UIScreen.main.bounds.height }
    
    static var isPortrait: Bool { return UIDevice.current.orientation.isPortrait }
}
