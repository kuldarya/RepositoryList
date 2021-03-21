//
//  BitBucketResponseModel.swift
//  RepositoryList
//
//  Created by Darya Kuliashova on 21.03.21.
//

import Foundation

struct BitBucketResponseModel: Codable {
    let values: [Value]
}

struct Value: Codable {
    let bitbucketOwner: BitBucketOwner
    let repoName: String
    let repoDescription: String
    
    private enum CodingKeys: String, CodingKey {
        case bitbucketOwner = "owner"
        case repoName = "name"
        case repoDescription = "description"
    }
}

struct BitBucketOwner: Codable {
    let userName: String
    let links: Links
    
    private enum CodingKeys: String, CodingKey {
        case userName = "display_name"
        case links
    }
}

struct Links: Codable {
    let avatarURL: Avatar
    
    private enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar"
    }
}

struct Avatar: Codable {
    let href: String
}
