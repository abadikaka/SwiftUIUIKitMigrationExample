//
//  VIPERRouter.swift
//  UIKitSwiftUIMigration
//
//  Created by Michael Abadi Santoso on 19/11/2564 BE.
//

import Foundation
import UIKit

protocol VIPERRouterInput {
    func goToMVVMScreen()
}

protocol VIPERRouterOutput: AnyObject {
    func didGoToMVVMScreen()
}

class VIPERRouter: VIPERRouterInput {

    weak var vc: UIViewController?
    weak var output: VIPERRouterOutput?

    func goToMVVMScreen() {
        vc?.navigationController?.pushViewController(MVVMViewController.createViewController(), animated: true)
        output?.didGoToMVVMScreen()
    }
}
