//
//  GitHubModel.swift
//  RepositoryList
//
//  Created by Darya Kuliashova on 21.03.21.
//

import Foundation

struct GitHubModel {
    let repoName: String
    let repoDescription: String
    let userName: String
    let avatarUrl: String
}

struct GitHubMapper {
    static func map(_ model: GitHubResponseModel) -> GitHubModel {
        return GitHubModel(repoName: model.repoName,
                           repoDescription: model.repoDescription ?? "",
                           userName: model.githubOwner.userName,
                           avatarUrl: model.githubOwner.avatarURL)
    }
}
