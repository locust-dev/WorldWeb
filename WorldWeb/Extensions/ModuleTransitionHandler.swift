//
//  ModuleTransitionHandler.swift
//  FinchModuleTransitions
//
//  Created by Vladimir Pchelyakov on 01.04.2020.
//  Copyright © 2020 Finch Mobile. All rights reserved.
//

import UIKit

protocol ModuleTransitionHandler where Self: UIViewController {  }

extension ModuleTransitionHandler {
    
    func present<ModuleType: Assembly>(with model: TransitionModel, openModuleType: ModuleType.Type) {
        let view = ModuleType.assembleModule(with: model)
        present(view, animated: true)
    }
    
    func present<ModuleType: Assembly>(animated: Bool, moduleType: ModuleType.Type) {
        let view = ModuleType.assembleModule()
        present(view, animated: animated)
    }
    
    func present(viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        present(viewController, animated: animated, completion: completion)
    }
    
    func show<ModuleType: Assembly>(with model: TransitionModel, openModuleType: ModuleType) {
        let view = ModuleType.assembleModule(with: model)
        show(view, sender: nil)
    }
    
    func push<ModuleType: Assembly>(with model: TransitionModel, openModuleType: ModuleType.Type) {
        let view = ModuleType.assembleModule(with: model)
        navigationController?.pushViewController(view, animated: true)
    }
    
    func push<ModuleType: Assembly>(moduleType: ModuleType.Type) {
        let view = ModuleType.assembleModule()
        navigationController?.pushViewController(view, animated: true)
    }
    
    func popToRootViewController(animated: Bool) {
        navigationController?.popToRootViewController(animated: animated)
    }
    
    func closeCurrentModule(animated: Bool = true) {
        
        let isInNavigationStack = parent is UINavigationController
        var hasManyControllersInStack = false
        
        if let navigationController = parent as? UINavigationController {
            hasManyControllersInStack = isInNavigationStack ? navigationController.children.count > 1 : false
        }
        
        if isInNavigationStack && hasManyControllersInStack {
            (parent as? UINavigationController)?.popViewController(animated: animated)
            
        } else if presentingViewController != nil {
            dismiss(animated: animated, completion: nil)
            
        } else if view.superview != nil {
            willMove(toParent: nil)
            view.removeFromSuperview()
            removeFromParent()
        }
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)?) {
        dismiss(animated: animated, completion: completion)
    }
    
}

extension UIViewController: ModuleTransitionHandler {  }
