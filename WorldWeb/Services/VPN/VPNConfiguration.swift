//
//  VPNConfiguration.swift
//  WorldWeb
//
//  Created by Ilya Turin on 19.03.2022.
//

import NetworkExtension

struct VPNConfiguration {
    
    let serverAddress = "46.102.156.27"
    let username = "vpnuser"
    let password = "yeGTjTybh52k7YJP"
    let sharedKey = "SWnzjYP4VfxUnXa6TNwU"
    let authMethod: NEVPNIKEAuthenticationMethod = .sharedSecret
}
