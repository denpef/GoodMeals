import Foundation

protocol CellViewType: AnyObject, ReusableView {
    associatedtype ViewModelType: CellViewModelType
    func configure(with viewModel: ViewModelType)
}

protocol CellViewModelType {
    associatedtype CellType: CellViewType
    static var reuseIdentifier: String { get }
}

extension CellViewModelType {
    static var reuseIdentifier: String {
        return CellType.reuseIdentifier
    }
}
