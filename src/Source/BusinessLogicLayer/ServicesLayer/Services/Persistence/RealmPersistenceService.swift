import Foundation
import RealmSwift


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
        realm.add(value.managedObject, update: update)
    }
    
    func add<T: Sequence>(_ values: T, update: Bool = false) where T.Iterator.Element: Persistable {
        values.forEach { add($0, update: update) }
    }
    
    func delete<T: Persistable>(_ value: T) {
        let realm = getRealm()
        realm.delete(value.managedObject)
    }
    
    func delete<T: Sequence>(_ values: T) where T.Iterator.Element: Persistable {
        let realm = getRealm()
        realm.delete(values.map { $0.managedObject })
    }
    
    func objects<T: Persistable>(_ type: T.Type,
                                 filter: NSPredicate?,
                                 sortDescriptors: [SortDescriptor]? = nil) -> [T] {
        
        let realm = getRealm()
        
        var objects: Results<T.ManagedObject> = realm.objects(type.ManagedObject.self)
        
        if let predicate = filter {
            objects = objects.filter(predicate)
        }
        
        if let sortDescriptors = sortDescriptors, !sortDescriptors.isEmpty {
            objects = objects.sorted(by: sortDescriptors)
        }
        
        return objects.map { T(managedObject: $0) }
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
