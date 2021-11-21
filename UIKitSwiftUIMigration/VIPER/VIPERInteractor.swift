//
//  VIPERInteractor.swift
//  UIKitSwiftUIMigration
//
//  Created by Michael Abadi Santoso on 19/11/2564 BE.
//

import Foundation

protocol VIPERInteractorInput {
    func fetch()
}

protocol VIPERInteractorOutput: AnyObject {
    func didReceive(_ entities: [VIPEREntity])
}

class VIPERInteractor: VIPERInteractorInput {

    private let database = Database()

    weak var output: VIPERInteractorOutput?

    func fetch() {
        let data = database.retrieve()
        let entities = data.compactMap {
            VIPEREntity(name: $0.name)
        }
        output?.didReceive(entities)
    }
}
