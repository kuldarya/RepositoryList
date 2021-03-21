//
//  ElementsViewController.swift
//  RepositoryList
//
//  Created by Darya Kuliashova on 21.03.21.
//

import UIKit

class ElementsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let elementApiClient = ElementAPIClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        elementApiClient.fetchBitbucketElements { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let bitbucketElements):
                print("bitbucketElements successfully fethed")

//                self.elements = bitbucketElements.values as [Any]
            case .failure(let error):
                assertionFailure(error.localizedDescription)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        elementApiClient.fetchGithubElements { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let githubElements):
                print("githubElements successfully fethed")

//                self.elements = githubElements as [Any]
            case .failure(let error):
                assertionFailure(error.localizedDescription)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            print("all elements were successfully fetched")
            self.tableView.reloadData()
        }
    }
}

