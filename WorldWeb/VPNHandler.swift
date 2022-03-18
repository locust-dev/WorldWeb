//
//  VPNHandler.swift
//  WorldWeb
//
//  Created by Ilya Turin on 18.03.2022.
//

import Foundation
import NetworkExtension
import Security

final class VPNHandler {
    
    let vpnManager = NEVPNManager.shared()
    
   
    let authMethod: NEVPNIKEAuthenticationMethod = .sharedSecret
    
    
    func connectVPN() {
        
        let serverAddress = "46.102.156.27"
        let username = "vpnuser"
        let password = "yeGTjTybh52k7YJP"
        let sharedKey = "SWnzjYP4VfxUnXa6TNwU"
        
        vpnManager.loadFromPreferences { error in
            
            guard error == nil else {
                return
            }
            
            let p = NEVPNProtocolIPSec()
            p.username = username
            p.serverAddress = serverAddress
            p.authenticationMethod = .sharedSecret
            
            let kcs = KeychainService()
            kcs.save(key: "PASS", value: password)
            kcs.save(key: "PSK", value: sharedKey)
            
            p.sharedSecretReference = kcs.load(key: "PSK")
            p.passwordReference = kcs.load(key: "PASS")
            
            p.useExtendedAuthentication = true
            p.disconnectOnSleep = false
        
            self.vpnManager.protocolConfiguration = p
            self.vpnManager.localizedDescription = "Custom"
            self.vpnManager.isEnabled = true
            
            self.vpnManager.saveToPreferences { error in
                
                guard error == nil else {
                    return
                }
                
                do {
                    try self.vpnManager.connection.startVPNTunnel()
                } catch let error {
                    print(error)
                }
            }
        }
    }
    
    func disconnectVPN() {
        vpnManager.connection.stopVPNTunnel()
    }
}


final class KeychainService {
    
    // Identifiers
    let serviceIdentifier = "MySerivice"
    let userAccount = "authenticatedUser"
    let accessGroup = "MySerivice"
    
    // Arguments for the keychain queries
    var kSecAttrAccessGroupSwift = NSString(format: kSecClass)
    
    let kSecClassValue = kSecClass as CFString
    let kSecAttrAccountValue = kSecAttrAccount as CFString
    let kSecValueDataValue = kSecValueData as CFString
    let kSecClassGenericPasswordValue = kSecClassGenericPassword as CFString
    let kSecAttrServiceValue = kSecAttrService as CFString
    let kSecMatchLimitValue = kSecMatchLimit as CFString
    let kSecReturnDataValue = kSecReturnData as CFString
    let kSecMatchLimitOneValue = kSecMatchLimitOne as CFString
    let kSecAttrGenericValue = kSecAttrGeneric as CFString
    let kSecAttrAccessibleValue = kSecAttrAccessible as CFString
    
    func save(key: String, value: String) {
        let keyData: Data = key.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue), allowLossyConversion: false)!
        let valueData: Data = value.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue), allowLossyConversion: false)!
        
        let keychainQuery = NSMutableDictionary();
        keychainQuery[kSecClassValue as! NSCopying] = kSecClassGenericPasswordValue
        keychainQuery[kSecAttrGenericValue as! NSCopying] = keyData
        keychainQuery[kSecAttrAccountValue as! NSCopying] = keyData
        keychainQuery[kSecAttrServiceValue as! NSCopying] = "VPN"
        keychainQuery[kSecAttrAccessibleValue as! NSCopying] = kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
        keychainQuery[kSecValueData as! NSCopying] = valueData;
        // Delete any existing items
        SecItemDelete(keychainQuery as CFDictionary)
        SecItemAdd(keychainQuery as CFDictionary, nil)
    }
    
    func load(key: String) -> Data {
        
        let keyData: Data = key.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue), allowLossyConversion: false)!
        let keychainQuery = NSMutableDictionary();
        keychainQuery[kSecClassValue as! NSCopying] = kSecClassGenericPasswordValue
        keychainQuery[kSecAttrGenericValue as! NSCopying] = keyData
        keychainQuery[kSecAttrAccountValue as! NSCopying] = keyData
        keychainQuery[kSecAttrServiceValue as! NSCopying] = "VPN"
        keychainQuery[kSecAttrAccessibleValue as! NSCopying] = kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
        keychainQuery[kSecMatchLimit] = kSecMatchLimitOne
        keychainQuery[kSecReturnPersistentRef] = kCFBooleanTrue
        
        var result: AnyObject?
        let status = withUnsafeMutablePointer(to: &result) { SecItemCopyMatching(keychainQuery, UnsafeMutablePointer($0)) }
        
        
        if status == errSecSuccess {
            if let data = result as! NSData? {
                if let value = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue) {
                }
                return data as Data;
            }
        }
        return "".data(using: .utf8)!;
    }
}
