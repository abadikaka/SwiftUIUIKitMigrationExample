//
//  VIPERViewController.swift
//  UIKitSwiftUIMigration
//
//  Created by Michael Abadi Santoso on 19/11/2564 BE.
//

import UIKit

protocol VIPERViewInput {
    func update(_ viewModel: [VIPERViewModel])
}

class VIPERViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var viewModels: [VIPERViewModel] = []
    private var colors: [UIColor] = [.red, .yellow, .blue, .brown]

    var presenter: VIPERPresenterInput?

    deinit {
        print("DEALLOC")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CounterViewCell", bundle: nil), forCellReuseIdentifier: "counterViewCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }

    @IBAction func handleGoToButton(_ sender: Any) {
        presenter?.didTapNavigation()
    }

    static func createViewController() -> UIViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VIPERViewController") as? VIPERViewController
        let presenter = VIPERPresenter()
        let router = VIPERRouter()
        let interactor = VIPERInteractor()
        presenter.router = router
        router.vc = vc
        presenter.interactor = interactor
        interactor.output = presenter
        presenter.view = vc
        vc?.presenter = presenter
        return vc ?? UIViewController()
    }

}

extension VIPERViewController: VIPERViewInput {
    func update(_ viewModel: [VIPERViewModel]) {
        self.viewModels = viewModel
    }
}

extension VIPERViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = cell as? CounterViewCell
        cell?.backgroundColor = colors[Int.random(in: 0..<colors.count)]
        let model = viewModels[indexPath.row]
        cell?.label.text = model.name + " - - - - \(model.counter)"
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didTapUpdate(at: indexPath.row)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

extension VIPERViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "counterViewCell", for: indexPath) as? CounterViewCell
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}

extension VIPERViewController: CounterViewCellDelegate {
    func didTapUpdate(_ viewCell: UITableViewCell) {
        let index = tableView.indexPath(for: viewCell) ?? IndexPath(row: 0, section: 0)
        presenter?.didTapUpdate(at: index.row)
        tableView.reloadRows(at: [index], with: .automatic)
    }
}
