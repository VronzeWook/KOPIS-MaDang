//
//  KeychainHelper.swift
//  MaDang
//
//  Created by LDW on 8/20/24.
//

import Foundation

// MARK: - UserIdentifier를 Keychain으로 관리
class KeychainHelper {
    static let shared = KeychainHelper()

    // Keychain에 UserIdentifier 저장
    func saveUserIdentifier(_ userIdentifier: String) {
        let data = Data(userIdentifier.utf8)
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: "userIdentifier",
            kSecValueData: data
        ] as CFDictionary

        SecItemDelete(query)
        let status = SecItemAdd(query, nil)
        
        if status == errSecSuccess {
            print("UserIdentifier saved successfully.")
        } else {
            print("Failed to save UserIdentifier.")
        }
    }
    
    // Keychain에서 UserIdentifier 읽기
    func readUserIdentifier() -> String? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: "userIdentifier",
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as CFDictionary

        var result: AnyObject?
        let status = SecItemCopyMatching(query, &result)

        if status == errSecSuccess {
            if let data = result as? Data {
                return String(data: data, encoding: .utf8)
            }
        }
        
        return nil
    }
    
    // Keychain에서 UserIdentifier 삭제
    func deleteUserIdentifier() {
          let query = [
              kSecClass: kSecClassGenericPassword,
              kSecAttrAccount: "userIdentifier"
          ] as CFDictionary

          let status = SecItemDelete(query)
          
          if status == errSecSuccess {
              print("UserIdentifier deleted successfully.")
          } else {
              print("Failed to delete UserIdentifier.")
          }
      }
}
