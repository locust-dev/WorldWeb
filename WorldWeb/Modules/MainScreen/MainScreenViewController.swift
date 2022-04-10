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
    
    private let switcher = UISwitch()
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
        
        switcher.setSize(width: 120)
        switcher.onTintColor = .blue
        switcher.addTarget(self, action: #selector(switchTap(switcher:)), for: .valueChanged)
        
        statusLabel.textColor = .white
        statusLabel.font = UIFont.systemFont(ofSize: 20)
    
        view.addSubview(switcher)
        view.addSubview(statusLabel)
        
        switcher.autoCenterInSuperview()
        
        statusLabel.autoPinEdge(.top, to: .bottom, of: switcher, withOffset: 50)
        statusLabel.autoAlignAxis(.vertical, toSameAxisOf: switcher)
    }
    
    
    // MARK: - Actions
    
    @objc private func switchTap(switcher: UISwitch) {
        presenter?.didTapSwitcher()
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
