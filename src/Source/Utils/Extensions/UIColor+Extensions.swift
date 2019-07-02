import UIKit.UIColor

extension UIColor {
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
