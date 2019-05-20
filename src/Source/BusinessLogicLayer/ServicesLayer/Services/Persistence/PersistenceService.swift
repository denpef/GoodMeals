import Foundation
import RealmSwift

protocol PersistenceService {
    func add<T: Persistable>(_ value: T, update: Bool)
    func add<T: Sequence>(_ values: T, update: Bool) where T.Iterator.Element: Persistable
    func delete<T: Persistable>(_ value: T)
    func delete<T: Sequence>(_ values: T) where T.Iterator.Element: Persistable
    func objects<T: Persistable>(_ type: T.Type, filter: NSPredicate?, sortDescriptors: [SortDescriptor]?) -> [T]
    func clearAll()
}
