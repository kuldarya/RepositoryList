//
//  GitHubResponseModel.swift
//  RepositoryList
//
//  Created by Darya Kuliashova on 21.03.21.
//

import Foundation

struct GitHubResponseModel: Codable {
    let id: Int
    let repoName: String
    let githubOwner: GitHubOwner
    let repoDescription: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case repoName = "name"
        case githubOwner = "owner"
        case repoDescription = "description"
    }
}

struct GitHubOwner: Codable {
    let userName: String
    let avatarURL: String
    
    private enum CodingKeys: String, CodingKey {
        case userName = "login"
        case avatarURL = "avatar_url"
    }
}
