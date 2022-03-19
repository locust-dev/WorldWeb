//
//  MainScreenAssembly.swift
//  WorldWeb
//
//  Created Ilya Turin on 19.03.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

final class MainScreenAssembly: Assembly {
    
    static func assembleModule() -> Module {
        
        let vpnService = VPNService.shared
        
        let view = MainScreenViewController()
        let router = MainScreenRouter(transition: view)
        let presenter = MainScreenPresenter()
        let interactor = MainScreenInteractor(vpnService: vpnService)
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        return view
    }

}
