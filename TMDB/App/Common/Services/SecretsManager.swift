import Foundation

class SecretsManager {
    static let shared = SecretsManager()
    
    private var secrets: [String: Any]?

    private init() {
        loadSecrets()
    }

    private func loadSecrets() {
        guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let dictionary = NSDictionary(contentsOfFile: path) as? [String: Any] else {
            return
        }
        secrets = dictionary
    }

    func getValue(forKey key: String) -> String {
        guard let secrets = secrets else {
            fatalError("error load \(key) value")
        }
        return secrets[key] as! String
    }
}
