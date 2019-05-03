import Foundation

protocol ServiceLocator {
    func get<T>() -> T?
}

final class ServiceLocatorImpl: ServiceLocator {
    private var services = [String: Any]()
    
    private func typeName(_ some: Any) -> String {
        return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
    }
    
    func register<T>(service: T) {
        let key = typeName(T.self)
        services[key] = service
    }
    
    func get<T>() -> T? {
        let key = typeName(T.self)
        return services[key] as? T
    }
}
