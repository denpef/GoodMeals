import Foundation
import RealmSwift

enum RealmDefaultConfiguration {
    static let fileName = "default.realm"

    static var inBundle: Realm.Configuration {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            fatalError("No Raeal bundle")
        }
        return Realm.Configuration(fileURL: url)
    }

    static var inDocuments: Realm.Configuration {
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
