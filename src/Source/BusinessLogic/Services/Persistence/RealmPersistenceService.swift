import Foundation
import RealmSwift

public protocol PersistenceNotificationOutput: class {
    func didChanged<T: Persistable>(_ changes: PersistenceNotification<T>)
}

public enum PersistenceNotification<T> {
    case error(Error)
    case initial([T])
    case update([T], deletions: [Int], insertions: [Int], modifications: [Int])
}

final class RealmPersistenceService: PersistenceService {
    private var config: Realm.Configuration
    
    public convenience init(inMemoryIdentifier: String) {
        var configuration = Realm.Configuration()
        configuration.inMemoryIdentifier = inMemoryIdentifier
        self.init(configuration: configuration)
    }
    
    required init(configuration: Realm.Configuration) {
        self.config = configuration
    }
    
    func add<T: Persistable>(_ value: T, update: Bool = false) {
        let realm = getRealm()
        write(realm: realm) {
            realm.add(value.managedObject, update: update ? .all : .error)
        }
    }
    
    func add<T: Sequence>(_ values: T, update: Bool = false) where T.Iterator.Element: Persistable {
        let realm = getRealm()
        write(realm: realm) {
            values.forEach {
                add($0, update: update)
            }
        }
    }
    
    func delete<T: Persistable>(_ value: T) {
        let realm = getRealm()
        let managedType = T.ManagedObject.self
        if
            let primaryKeyType = managedType.primaryKey(),
            let primaryKeyValue = value.managedObject.value(forKey: primaryKeyType) {
            if let objectForDelete = realm.object(ofType: managedType, forPrimaryKey: primaryKeyValue) {
                write(realm: realm) {
                    realm.delete(objectForDelete)
                }
            }
        }
    }
    
    func delete<T: Sequence>(_ values: T) where T.Iterator.Element: Persistable {
        let realm = getRealm()
        write(realm: realm) {
            realm.delete(values.map { $0.managedObject })
        }
    }
    
    func delete<T: Persistable>(type: T.Type) {
        let realm = getRealm()
        write(realm: realm) {
            realm.delete(realm.objects(type.ManagedObject.self))
        }
    }
    
    func objects<T: Persistable>(_ type: T.Type,
                                 filter: NSPredicate?,
                                 sortDescriptors: [SortDescriptor]? = nil) -> [T] {
        
        let realm = getRealm()
        
        var objects: Results<T.ManagedObject> = realm.objects(type.ManagedObject.self)
        
        if let filter = filter {
            objects = objects.filter(filter)
        }
        
        if let sortDescriptors = sortDescriptors, !sortDescriptors.isEmpty {
            objects = objects.sorted(by: sortDescriptors)
        }
        
        return objects.map {
            T(managedObject: $0)
        }
    }
    
    func subscribeCollection<T: Persistable>(_ type: T.Type,
                                             subscriber: PersistenceNotificationOutput,
                                             filter: NSPredicate? = nil,
                                             sortDescriptors: [SortDescriptor]? = nil) -> NotificationToken {
        
        let realm = getRealm()
        var results = realm.objects(type.ManagedObject.self)
        
        if let filter = filter {
            results = results.filter(filter)
        }
        
        if let sortDescriptors = sortDescriptors, !sortDescriptors.isEmpty {
            results = results.sorted(by: sortDescriptors)
        }
        
        return results.observe { [weak subscriber] change in
            switch change {
            case let .error(error):
                subscriber?.didChanged(PersistenceNotification<T>.error(error))
            case let .initial(objects):
                subscriber?.didChanged(.initial(objects.map { T.init(managedObject: $0) }))
            case let .update(updates, deletions, insertions, modifications):
                subscriber?.didChanged(.update(updates.map { T.init(managedObject: $0) },
                                               deletions: deletions,
                                               insertions: insertions,
                                               modifications: modifications)
                )
            }
        }
    }
    
    func clearAll() {
        let realm = getRealm()
        write(realm: realm) {
            realm.deleteAll()
        }
    }
    
    // MARK: -Private functions
    
    private func write(realm: Realm?, _ block: (() -> Void)) {
        if let realm = realm {
            if realm.isInWriteTransaction {
                block()
            } else {
                try! realm.write(block)
            }
        } else {
            assertionFailure("Realm not found")
        }
    }
    
    private func getRealm() -> Realm {
        do {
            let realm = try Realm(configuration: config)
            return realm
        } catch {
            fatalError("Realm schema changed. Error: \(error.localizedDescription)")
        }
    }
}
