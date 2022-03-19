//
//  MainScreenViewController.swift
//  WorldWeb
//
//  Created by Ilya Turin on 18.03.2022.
//

import UIKit
import PureLayout

protocol MainScreenViewInput: AnyObject {
    func updateStatusLabel(_ statusText: String?)
}

final class MainScreenViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: MainScreenViewOutput?
    
    private let mainButton = UIButton()
    private let statusLabel = UILabel()
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: - Вывести обзервера в VPNService
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(vpnStatusDidChange(_:)),
            name: NSNotification.Name.NEVPNStatusDidChange,
            object: nil
        )
        
        drawSelf()
        presenter?.viewIsReady()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        view.backgroundColor = .black
        
        statusLabel.textColor = .white
        statusLabel.font = UIFont.systemFont(ofSize: 20)
        
        mainButton.addTarget(self, action: #selector(mainButtonTap), for: .touchUpInside)
        mainButton.layer.cornerRadius = 50
        mainButton.backgroundColor = .purple
        
        view.addSubview(mainButton)
        view.addSubview(statusLabel)
        
        mainButton.autoSetDimensions(to: CGSize(width: 100, height: 100))
        mainButton.autoCenterInSuperview()
        
        statusLabel.autoPinEdge(.top, to: .bottom, of: mainButton, withOffset: 20)
        statusLabel.autoAlignAxis(.vertical, toSameAxisOf: mainButton)
    }
    
    
    // MARK: - Actions
    
    @objc private func mainButtonTap() {
        presenter?.didTapMainButton()
    }
    
    @objc private func vpnStatusDidChange(_: NSNotification?) {
        presenter?.vpnStatusDidChange()
    }
    
}


// MARK: - MainScreenViewInput
extension MainScreenViewController: MainScreenViewInput {
    
    func updateStatusLabel(_ statusText: String?) {
        statusLabel.text = statusText
    }

}
