//
//  VPNService.swift
//  WorldWeb
//
//  Created by Ilya Turin on 18.03.2022.
//

import Foundation
import NetworkExtension

protocol VPNServiceInput {
    
    var status: NEVPNStatus { get }
    var isDisconnected: Bool { get }
    
    func connect()
    func disconnect()
}

final class VPNService {
    
    // MARK: - Locals
    
    private enum Locals {
        
        static let passwordReferenceKey = "PASS"
        static let pskReferenceKey = "PSK"
        static let localizedDescription = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String
    }
    
    
    // MARK: - Properties
    
    static let shared = VPNService()
    
    private let manager = NEVPNManager.shared()
    private let keychainService: KeychainServiceInput
    private let receiver: VPNDataReceiverInput
    
    
    // MARK: - Init
    
    private init() {
        keychainService = KeychainService()
        receiver = VPNDataReceiver()
    }
}


// MARK: - VPNServiceInput
extension VPNService: VPNServiceInput {
    
    var status: NEVPNStatus {
        manager.connection.status
    }
    
    var isDisconnected: Bool {
        get {
            return (status == .disconnected)
                || (status == .reasserting)
                || (status == .invalid)
        }
    }
    
    func connect() {
        
        fetchConfiguration { [weak self] configuration in
            
            guard let configuration = configuration else {
                // TODO: - Обработать
                return
            }
            
            self?.load {
                
                let protocolConfiguration = self?.configureProtocol(configuration)
                self?.manager.protocolConfiguration = protocolConfiguration
                self?.manager.localizedDescription = Locals.localizedDescription
                self?.manager.isEnabled = true
                self?.save {
                    self?.load {
                        self?.startVPNTunnel()
                    }
                }
            }
        }
        
    }
    
    func disconnect() {
        manager.connection.stopVPNTunnel()
    }
}


// MARK: - Private methods
extension VPNService {
    
    private func fetchConfiguration(completion: @escaping (VPNConfiguration?) -> Void) {
        
        receiver.fetchConfiguration { result in
            
            switch result {
                
            case .success(let configuration):
                completion(configuration)
                
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    private func configureProtocol(_ configuration: VPNConfiguration) -> NEVPNProtocolIPSec {
        
        let vpnProtocol = NEVPNProtocolIPSec()
        vpnProtocol.username = configuration.username
        vpnProtocol.serverAddress = configuration.serverAdress
        vpnProtocol.authenticationMethod = .sharedSecret
        
        keychainService.save(key: Locals.passwordReferenceKey, value: configuration.password)
        keychainService.save(key: Locals.pskReferenceKey, value: configuration.sharedKey)
        vpnProtocol.sharedSecretReference = keychainService.load(key: Locals.pskReferenceKey)
        vpnProtocol.passwordReference = keychainService.load(key: Locals.passwordReferenceKey)
        vpnProtocol.useExtendedAuthentication = true
        vpnProtocol.disconnectOnSleep = false
        
        return vpnProtocol
    }
    
    private func load(completion: (() -> Void)? = nil) {
        manager.protocolConfiguration = nil
        manager.loadFromPreferences { self.onError(error: $0, completion: completion) }
    }
    
    private func save(completion: (() -> Void)? = nil) {
        manager.saveToPreferences { self.onError(error: $0, completion: completion) }
    }
    
    private func onError(error: Error?, completion: (() -> Void)? = nil) {
        
        if let error = error {
            // TODO: - Обработка
            print(error.localizedDescription)
            return
        } else {
            completion?()
        }
    }
    
    private func startVPNTunnel() {
        
        do {
            try manager.connection.startVPNTunnel()
            
        } catch NEVPNError.configurationInvalid {
            print("Failed to start tunnel (configuration invalid)")
            
        } catch NEVPNError.configurationDisabled {
            print("Failed to start tunnel (configuration disabled)")
            
        } catch {
            print("Failed to start tunnel (other error)")
        }
    }
}
