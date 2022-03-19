//
//  MainScreenInteractor.swift
//  WorldWeb
//
//  Created Ilya Turin on 19.03.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

protocol MainScreenInteractorInput {
    
    var isDisconnected: Bool { get }
    var statusDescription: String { get }
    
    func connect(configuration: VPNConfiguration)
    func disconnect()
}

final class MainScreenInteractor {
    
    // MARK: - Properties
    
    weak var presenter: MainScreenInteractorOutput?
    
    private let vpnService: VPNServiceInput
    
    
    // MARK: - Init
    
    init(vpnService: VPNServiceInput) {
        self.vpnService = vpnService
    }
    
}


// MARK: - MainScreenInteractorInput
extension MainScreenInteractor: MainScreenInteractorInput {
    
    var isDisconnected: Bool {
        vpnService.isDisconnected
    }
    
    var statusDescription: String {
        vpnService.status.description
    }
    
    func connect(configuration: VPNConfiguration) {
        vpnService.connect(configuration: configuration)
    }
    
    func disconnect() {
        vpnService.disconnect()
    }
}
