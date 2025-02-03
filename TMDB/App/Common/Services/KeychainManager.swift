import Foundation
import Security

class KeychainManager {
    static let shared = KeychainManager()

    func save(key: String, data: Data) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }
    func save(key: String, string: String) {
        guard let data = string.data(using: .utf8) else { return }
        save(key: key, data: data)
    }

    func get(key: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var item: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &item)

        if status == errSecSuccess {
            return item as? Data
        } else {
            return nil
        }
    }

    func getString(key: String) -> String? {
        guard let data = get(key: key) else { return nil }
        return String(data: data, encoding: .utf8)
    }

    func delete(key: String) {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ]

        SecItemDelete(query as CFDictionary)
    }
}
