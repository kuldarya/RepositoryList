//
//  ElementAPIClient.swift
//  ListOfElements
//
//  Created by Darya Kuliashova on 18.03.21.
//

import Foundation

final class ElementAPIClient {
    static func fetchBitbucketElements(completion: @escaping ((Result<BitBucketResponseModel, Error>)) -> Void) {
        APIClient.fetch(route: APIRouter.getBitbucketElements) { (result: Result<BitBucketResponseModel, Error>) in
            switch result {
            case .success(let bitbucket):
                completion(.success(bitbucket))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func fetchGithubElements(completion: @escaping (Result<[GitHubResponseModel], Error>) -> Void) {
        APIClient.fetch(route: APIRouter.getGithubElements) { (result: Result<[GitHubResponseModel], Error>) in
            switch result {
            case .success(let github):
                completion(.success(github))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
