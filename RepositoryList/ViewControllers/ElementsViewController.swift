//
//  ElementsViewController.swift
//  RepositoryList
//
//  Created by Darya Kuliashova on 21.03.21.
//

import UIKit

class ElementsViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private let elementApiClient = ElementAPIClient()
    
    var viewModel: ElementsViewModel = .empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.title = "List of Elements"
        
        fetchAllElements()
    }
    
    func fetchAllElements() {
        FetchManager.fetch(viewModel: viewModel) { result in
            switch result {
            case .success(let elements):
                self.viewModel.elements = elements
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension ElementsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ElementCell.className, for: indexPath) as? ElementCell else {
            return UITableViewCell()
        }
        cell.element = viewModel.elements[indexPath.row]
        

        return cell
    }
}

extension ElementsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let controller = UIStoryboard.mainStoryboard?.instantiateVC(ElementDetailsViewController.self) else {
            assertionFailure()
            return
        }
        controller.element = viewModel.elements[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}

