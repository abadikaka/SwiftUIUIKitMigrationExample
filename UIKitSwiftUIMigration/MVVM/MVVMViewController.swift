//
//  MVVMViewController.swift
//  UIKitSwiftUIMigration
//
//  Created by Michael Abadi Santoso on 19/11/2564 BE.
//

import UIKit
import SwiftUI

class MVVMViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var viewModel = MVVMViewModel()

    private var colors: [UIColor] = [.red, .yellow, .blue, .brown]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CounterViewCell", bundle: nil), forCellReuseIdentifier: "counterViewCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetch()
    }

    static func createViewController() -> UIViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MVVMViewController") as? MVVMViewController
        let vm = MVVMViewModel()
        vm.delegate = vc
        vc?.viewModel = vm
        return vc ?? UIViewController()
    }
    
//
//    static func createViewController() -> UIViewController {
//        let vm = MVVMViewModel()
//        let adapter = MVVMAdapter(viewModel: vm)
//        vm.delegate = adapter
//        let view = MMVMSWiftUI(viewModel: adapter)
//        let hc = UIHostingController(rootView: view)
//        return hc
//    }

}

extension MVVMViewController: MVVMViewModelDelegate {
    func didUpdate(_ models: [MVVMModel]) {

    }
}
extension MVVMViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as? CounterViewCell
        cell?.backgroundColor = colors[Int.random(in: 0..<colors.count)]
        let model = viewModel.models[indexPath.row]
        cell?.label.text = model.name + " - - - - \(model.counter)"
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.update(at: indexPath.row)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

extension MVVMViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "counterViewCell", for: indexPath) as? CounterViewCell
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.models.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

extension MVVMViewController: CounterViewCellDelegate {
    func didTapUpdate(_ viewCell: UITableViewCell) {
        let index = tableView.indexPath(for: viewCell) ?? IndexPath(row: 0, section: 0)
        viewModel.update(at: index.row)
        tableView.reloadRows(at: [index], with: .automatic)
    }
}
