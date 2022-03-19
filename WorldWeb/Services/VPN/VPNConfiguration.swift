//
//  VPNConfiguration.swift
//  WorldWeb
//
//  Created by Ilya Turin on 19.03.2022.
//

struct VPNConfiguration: Decodable {
    
    let serverAdress: String
    let username: String
    let password: String
    let sharedKey: String
}
