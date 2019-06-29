import UIKit

extension UIButton {
    func setImage(_ image: UIImage, tintColor: UIColor) {
        let tintableImage = image.withRenderingMode(.alwaysTemplate)
        setImage(tintableImage, for: .normal)
        self.tintColor = tintColor
    }
}
