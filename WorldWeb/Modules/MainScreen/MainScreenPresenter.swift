//
//  MainScreenPresenter.swift
//  WorldWeb
//
//  Created Ilya Turin on 19.03.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

protocol MainScreenViewOutput: ViewOutput {
    func didTapMainButton()
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
    }
    
    func didTapMainButton() {
        
        if interactor?.isDisconnected == true {
            let configuration = VPNConfiguration()
            interactor?.connect(configuration: configuration)
            
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
