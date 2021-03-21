//
//  ElementType.swift
//  RepositoryList
//
//  Created by Darya Kuliashova on 21.03.21.
//

import Foundation

enum ElementType {
    case bitbucket(type: BitBucketModel)
    case github(type: GitHubModel)
}
