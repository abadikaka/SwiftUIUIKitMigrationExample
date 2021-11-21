//
//  MVVMViewModel.swift
//  UIKitSwiftUIMigration
//
//  Created by Michael Abadi Santoso on 19/11/2564 BE.
//

import Foundation

struct MVVMModel {
    let name: String
    var counter: Int
}

struct Model {
    let name: String
}

class Database {
    private var data: [Model] = []

    init() {
        data = [
            Model(name: "Azis"),
            Model(name: "Nico"),
            Model(name: "Ferry"),
            Model(name: "Michael")
        ]
    }

    func retrieve() -> [Model] {
        data
    }
}

protocol MVVMViewModelDelegate: AnyObject {
    func didUpdate(_ models: [MVVMModel])
}

protocol MVVMViewModelAction {
    func fetch()
    func update(at index: Int)
}

class MVVMViewModel: MVVMViewModelAction {

    private let database = Database()

    var models: [MVVMModel] = []

    weak var delegate: MVVMViewModelDelegate?

    func fetch() {
        let data = database.retrieve()

        self.models = data.compactMap {
            MVVMModel(name: $0.name, counter: 0)
        }

        delegate?.didUpdate(models)
    }

    func update(at index: Int) {
        models[index].counter += 1
        delegate?.didUpdate(models)
    }

}
