//
//  MainScreenPresenter.swift
//  WorldWeb
//
//  Created Ilya Turin on 19.03.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

import Foundation

protocol MainScreenViewOutput: ViewOutput {
    func didTapSwitcher()
    func vpnStatusDidChange()
}

protocol MainScreenInteractorOutput: AnyObject {  }

final class MainScreenPresenter {
    
    // MARK: - Properties
    
    weak var view: MainScreenViewInput?
    
    var interactor: MainScreenInteractorInput?
    var router: MainScreenRouterInput?
    
}


// MARK: - MainScreenViewOutput
extension MainScreenPresenter: MainScreenViewOutput {
    
    func viewIsReady() {
        
        // MARK: - Решение
        view?.updateStatusLabel("Нажмите, чтобы подключиться")
        
//        let url = ""
//        let params: [String: Any] = [
//            "email": "rrrr.ty30@gmail.com"
//        ]
//
//        struct ConfigurationData: Decodable {
//            let server: String
//            let pass: String
//            let psk: String
//        }
//
//
//        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default)
//            .validate()
//            .responseJSON { data in
//
//
//        }
        
    }
    
    func didTapSwitcher() {
        
        if interactor?.isDisconnected == true {
            interactor?.connect()
            
        } else {
            interactor?.disconnect()
        }
    }
    
    func vpnStatusDidChange() {
        view?.updateStatusLabel(interactor?.statusDescription)
    }
}


// MARK: - MainScreenInteractorOutput
extension MainScreenPresenter: MainScreenInteractorOutput {  }
