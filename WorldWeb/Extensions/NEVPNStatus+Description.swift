//
//  NEVPNStatus+Description.swift
//  WorldWeb
//
//  Created by Ilya Turin on 19.03.2022.
//

import NetworkExtension

extension NEVPNStatus {
    
    var description: String {
        
        switch self {
            
        case .invalid:
            return "Ошибка конфигурации"
            
        case .disconnected:
            return "Нажмите, чтобы подключиться"
            
        case .connecting:
            return "Подключение..."
            
        case .connected:
            return "Подключено."
            
        case .reasserting:
            return "Переподключение..."
            
        case .disconnecting:
            return "Отключение..."
            
        @unknown default:
            fatalError("Unknown VPN status")
        }
    }
}
