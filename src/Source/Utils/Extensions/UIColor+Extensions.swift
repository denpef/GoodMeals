import UIKit.UIColor

// swiftlint:disable discouraged_object_literal
extension UIColor {
    enum Common {
        static var white: UIColor {
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // #FFFFFF
        }

        static var ghostWhite: UIColor {
            return #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 1, alpha: 1) // #F0F0FF
        }

        static var markedText: UIColor {
            return #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1) // #808080
        }

        static var controlBackground: UIColor {
            return #colorLiteral(red: 0.137254902, green: 0.1647058824, blue: 0.2352941176, alpha: 1) // #25242E
        }

        static var controlText: UIColor {
            return #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1) // #79D6F9
        }

        static var deleteItem: UIColor {
            return #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1) // #E87AA4
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
