//
//  FetchManager.swift
//  RepositoryList
//
//  Created by Darya Kuliashova on 21.03.21.
//

import Foundation

final class FetchManager {
    func fetch(viewModel: ElementsViewModel, completion: @escaping (Result<[ElementType], Error>) -> Void) {
        let elementApiClient = ElementAPIClient()

        let bitBucketMapper = BitBucketMapper()
        let gitHubMapper = GitHubMapper()
        var bitBucketModels: [BitBucketModel] = []
        var gitHubModels: [GitHubModel] = []
        
        let loadingFailed = false
        
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
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            if loadingFailed {
                completion(.failure(NetworkError.unableToLoad))
            } else {
                // save to local storage
                
                let elements: [ElementType] = bitBucketModels.map {
                    .bitbucket($0)
                } + gitHubModels.map {
                    .github($0)
                }
                completion(.success(elements))
            }
        }
    }
}
