import RealmSwift

enum RealmDefaultConfiguration {
    static let fileName = "default.realm"
    static var config: Realm.Configuration {
        let libraryUrl: URL
        do {
            libraryUrl = try FileManager.default.url(for: .libraryDirectory,
                                                     in: .userDomainMask,
                                                     appropriateFor: nil,
                                                     create: false).appendingPathComponent(fileName)
        } catch {
            fatalError("Failed finding expected path: \(error)")
        }
        return Realm.Configuration(fileURL: libraryUrl)
    }
}
