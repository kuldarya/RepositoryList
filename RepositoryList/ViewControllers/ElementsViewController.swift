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
        fetch { result in
            switch result {
            case .success:
                print("successfully loaded")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetch(completion: @escaping (Result<Any, Error>) -> Void) {
        let bitBucketMapper = BitBucketMapper()
        let gitHubMapper = GitHubMapper()
        
        var bitBucketModels: [BitBucketModel] = []
        var gitHubModels: [GitHubModel] = []
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        elementApiClient.fetchBitbucketElements { result in
            switch result {
            case .success(let bitbucketElements):
                bitBucketModels = bitbucketElements.values.map {
                    bitBucketMapper.map($0)
                }
            case .failure(let error):
                assertionFailure(error.localizedDescription)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        elementApiClient.fetchGithubElements { result in
            switch result {
            case .success(let githubElements):
                gitHubModels = githubElements.map {
                    gitHubMapper.map($0)
                }
            case .failure(let error):
                assertionFailure(error.localizedDescription)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) { [weak self] in
            guard let self = self else { return }
            
            let elements: [ElementType] = bitBucketModels.map {
                .bitbucket($0)
            } + gitHubModels.map {
                .github($0)
            }
            
            self.viewModel = ElementsViewModel(elements: elements)
            self.tableView.reloadData()
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

