import UIKit

enum Stylesheet {
    enum ServingCell {
        static let info = Style<UILabel> {
            $0.textAlignment = .center
            $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        }
    }
}
