//
//  VIPERPresenter.swift
//  UIKitSwiftUIMigration
//
//  Created by Michael Abadi Santoso on 19/11/2564 BE.
//

import Foundation

struct VIPERViewModel {
    let name: String
    var counter: Int
}

protocol VIPERPresenterInput {
    func viewWillAppear()
    func didTapUpdate(at index: Int)
    func didTapNavigation()
}

class VIPERPresenter: VIPERPresenterInput {

    private var models: [VIPERViewModel] = []

    var router: VIPERRouterInput?
    var interactor: VIPERInteractorInput?
    weak var view: VIPERViewController?

    func viewWillAppear() {
        interactor?.fetch()
    }

    func didTapUpdate(at index: Int) {
        models[index].counter += 1
        view?.update(models)
    }

    func didTapNavigation() {
        router?.goToMVVMScreen()
    }
}

extension VIPERPresenter: VIPERInteractorOutput {
    func didReceive(_ entities: [VIPEREntity]) {
        let models = entities.compactMap {
            VIPERViewModel(name: $0.name, counter: 0)
        }
        self.models = models
        view?.update(models)
    }
}

extension VIPERPresenter: VIPERRouterOutput {
    func didGoToMVVMScreen() {

    }
}
