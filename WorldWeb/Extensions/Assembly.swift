//
//  Assembly.swift
//  FinchModuleTransitions
//
//  Created by Vladimir Pchelyakov on 01.04.2020.
//  Copyright © 2020 Finch Mobile. All rights reserved.
//

import UIKit

typealias Module = UIViewController

protocol Assembly {
    static func assembleModule() -> Module
    static func assembleModule(with model: TransitionModel) -> Module
}

extension Assembly {
    
    static func assembleModule() -> Module {
        fatalError("Implement assembleModule() in ModuleAssembly")
    }
    
    static func assembleModule(with model: TransitionModel) -> Module {
        fatalError("Implement assembleModule(with model: TransitionModel) in ModuleAssembly")
    }
    
}
