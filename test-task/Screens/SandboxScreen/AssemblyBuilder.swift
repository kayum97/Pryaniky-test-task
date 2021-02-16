//
//  AssemblyBuilder.swift
//  test-task
//
//  Created by Admin on 16.02.2021.
//

import UIKit

class AssemblyBuilder {
    func createSandboxScreen() -> UIViewController {
        let sandboxViewController = SandboxViewController()
        let sandboxViewModel = SandboxViewModel()
        
        sandboxViewController.sandboxViewModel = sandboxViewModel
        
        return sandboxViewController
    }
}
