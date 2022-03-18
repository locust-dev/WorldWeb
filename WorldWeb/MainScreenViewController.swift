//
//  MainScreenViewController.swift
//  WorldWeb
//
//  Created by Ilya Turin on 18.03.2022.
//

import UIKit

final class MainScreenViewController: UIViewController {
    
    // MARK: - Properties
    
    private let mainButton = UIButton()
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawSelf()
    }
    
    
    // MARK: - Drawing
    
    private func drawSelf() {
        
        view.backgroundColor = .yellow
        
        mainButton.addTarget(self, action: #selector(activateVPN), for: .touchUpInside)
        mainButton.layer.cornerRadius = 50
        mainButton.backgroundColor = .purple
        
        view.addSubviewWithAutoLayout(mainButton)
        
        NSLayoutConstraint.activate([
            
            mainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainButton.heightAnchor.constraint(equalToConstant: 100),
            mainButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    
    // MARK: - Private methods
    
    @objc private func activateVPN() {
        
        let vpn = VPNHandler()
        vpn.connectVPN()
    }
    
    
}

extension UIView {
    
    func addSubviewWithAutoLayout(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }
}
