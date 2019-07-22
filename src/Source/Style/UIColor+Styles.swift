import UIKit.UIColor

// swiftlint:disable discouraged_object_literal
extension UIColor {
    enum Common {
        static var pictonBlue: UIColor {
            return #colorLiteral(red: 0.2, green: 0.7607843137, blue: 0.9019607843, alpha: 1) // #33C2E6
        }

        static var pictonBlueLight: UIColor {
            return #colorLiteral(red: 0.2, green: 0.7607843137, blue: 0.9019607843, alpha: 0.7) // #33C2E6 aplpha = 0.7
        }

        static var englishGreen: UIColor {
            return #colorLiteral(red: 0.1019607843, green: 0.3254901961, blue: 0.3607843137, alpha: 1) // #1A535C
        }

        static var englishGreenLight: UIColor {
            return #colorLiteral(red: 0.1019607843, green: 0.3254901961, blue: 0.3607843137, alpha: 0.6978274829) // #1A535C aplpha = 0.7
        }

        static var mintCream: UIColor {
            return #colorLiteral(red: 0.968627451, green: 1, blue: 0.968627451, alpha: 1) // #F7FFF7
        }

        static var pastelRed: UIColor {
            return #colorLiteral(red: 1, green: 0.4196078431, blue: 0.4196078431, alpha: 1) // #FF6B6B
        }

        static var pastelRedLight: UIColor {
            return #colorLiteral(red: 1, green: 0.4196078431, blue: 0.4196078431, alpha: 0.7) // #FF6B6B aplpha = 0.7
        }

        static var maize: UIColor {
            return #colorLiteral(red: 1, green: 0.9019607843, blue: 0.4274509804, alpha: 1) // #FFE66D
        }

        static var maizeLight: UIColor {
            return #colorLiteral(red: 1, green: 0.9019607843, blue: 0.4274509804, alpha: 0.7) // #FFE66D
        }
    }
}
