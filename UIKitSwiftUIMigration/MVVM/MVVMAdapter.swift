//
//  MVVMAdapter.swift
//  UIKitSwiftUIMigration
//
//  Created by Michael Abadi Santoso on 20/11/2564 BE.
//

import Foundation

struct MVVMNewModel: Identifiable {
    let id = UUID()
    let name: String
    var counter: Int
}

class MVVMAdapter: ObservableObject, MVVMViewModelDelegate, MVVMViewModelAction {

    var viewModel: MVVMViewModel
    @Published var models: [MVVMNewModel] = []

    init(viewModel: MVVMViewModel) {
        self.viewModel = viewModel
    }
    
    func didUpdate(_ models: [MVVMModel]) {
        self.models = models.compactMap {
            MVVMNewModel(name: $0.name, counter: $0.counter)
        }
    }

    func fetch() {
        viewModel.fetch()
    }

    func update(at index: Int) {
        viewModel.update(at: index)
    }
}
