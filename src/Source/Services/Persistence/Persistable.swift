import RealmSwift

/** Protocol represent internal models provides return database Object
 */
public protocol Persistable {
    associatedtype ManagedObject: Object

    init(managedObject: ManagedObject)

    var managedObject: ManagedObject { get }
}
