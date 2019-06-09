import UIKit.UIColor

extension UIColor {
    enum Common {
        static var white: UIColor {
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // #FFFFFF
        }
        
        static var ghostWhite: UIColor {
            return #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 1, alpha: 1) // #F0F0FF
        }
        
        static var controlBackground: UIColor {
            return #colorLiteral(red: 0.137254902, green: 0.1647058824, blue: 0.2352941176, alpha: 1) // #25242E
        }
        
        static var controlText: UIColor {
            return #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1) // #79D6F9
        }
    }
    
    /**
     Create round image filled by current color
     
     - Parameters:
     - diameter: size of width and height of image
     */
    func roundFilledImage(diameter: CGFloat) -> UIImage? {
        let size = CGSize(width: diameter, height: diameter)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        setFill()
        UIBezierPath(roundedRect: CGRect(origin: .zero, size: size), cornerRadius: diameter / 2).fill()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
