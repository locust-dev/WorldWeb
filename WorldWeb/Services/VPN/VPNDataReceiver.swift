//
//  VPNDataReceiver.swift
//  WorldWeb
//
//  Created by Ilya Turin on 19.03.2022.
//

import Foundation
import Alamofire

protocol VPNDataReceiverInput {
    func fetchConfiguration(completion: @escaping (Result<VPNConfiguration, ErrorModel>) -> Void)
}

final class VPNDataReceiver: VPNDataReceiverInput {
    
    // MARK: - Properties
    
    private let email = "rrrr.ty30@gmail.com"
    private let url = "https://bestworldvpn.herokuapp.com/api"
    
    
    // MARK: - Public methods
    
    func fetchConfiguration(completion: @escaping (Result<VPNConfiguration, ErrorModel>) -> Void) {
        
        let params: [String: Any] = [
            "email": email
        ]

        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { data in

                guard let data = data.data else {
                    completion(.failure(.serverError))
                    return
                }

                do {
                    let configuration = try JSONDecoder().decode(VPNConfiguration.self, from: data)
                    completion(.success(configuration))

                } catch let error {
                    print(error.localizedDescription)
                    completion(.failure(.serverError))
                }
            }
    }
    
}
