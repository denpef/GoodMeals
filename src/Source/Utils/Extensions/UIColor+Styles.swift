import UIKit.UIColor

// swiftlint:disable discouraged_object_literal
extension UIColor {
    enum Common {
        static var pictonBlue: UIColor {
            return #colorLiteral(red: 0.2, green: 0.7607843137, blue: 0.9019607843, alpha: 1) // #33C2E6
        }

        static var englishGreen: UIColor {
            return #colorLiteral(red: 0.1019607843, green: 0.3254901961, blue: 0.3607843137, alpha: 1) // #1A535C
        }

        static var mintCream: UIColor {
            return #colorLiteral(red: 0.968627451, green: 1, blue: 0.968627451, alpha: 1) // #F7FFF7
        }

        static var pastelRed: UIColor {
            return #colorLiteral(red: 1, green: 0.4196078431, blue: 0.4196078431, alpha: 1) // #FF6B6B
        }

        static var maize: UIColor {
            return #colorLiteral(red: 1, green: 0.9019607843, blue: 0.4274509804, alpha: 1) // #FFE66D
        }

        ///////
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

        static var subtitleLabelText: UIColor {
            return #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) // #41464D
        }

        static var infoLabelText: UIColor {
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3) // #000000 alpha: 0.3
        }
    }
}
