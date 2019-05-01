import UIKit.UIColor

public extension UIColor {
    enum Common {
        public static var white: UIColor {
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // #FFFFFF
        }
        
        public static var ghostWhite: UIColor {
            return #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 1, alpha: 1) // #F0F0FF
        }
    }
}
