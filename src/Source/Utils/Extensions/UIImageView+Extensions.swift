import SDWebImage
import UIKit

extension UIImageView {
    /// Start an async image download from URL
    ///
    /// - Parameters:
    ///   - path: URL path.
    public func loadImage(from path: String) {
        sd_setImage(with: URL(string: path))
    }

    /// Stops the async download of the image
    ///
    /// To avoid dirty response reading inside the reusable cell
    /// need to call this function inside the prepareForReuse:
    ///
    ///    override func prepareForReuse() {
    ///        super.prepareForReuse()
    ///        iconImageView.cancelImageLoading()
    ///    }
    public func cancelImageLoading() {
        sd_cancelCurrentImageLoad()
    }
}
