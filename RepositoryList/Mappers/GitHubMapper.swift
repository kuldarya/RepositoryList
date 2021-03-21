//
//  GitHubMapper.swift
//  RepositoryList
//
//  Created by Darya Kuliashova on 21.03.21.
//

import Foundation

struct GitHubMapper {
    func map(_ model: GitHubResponseModel) -> GitHubModel {
        GitHubModel(
            repoName: model.repoName,
            repoDescription: model.repoDescription ?? "",
            userName: model.githubOwner.userName,
            avatarUrl: model.githubOwner.avatarURL
        )
    }
}
