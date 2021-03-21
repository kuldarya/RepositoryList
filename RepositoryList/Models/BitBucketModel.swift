//
//  BitBucketModel.swift
//  RepositoryList
//
//  Created by Darya Kuliashova on 21.03.21.
//

import Foundation

struct BitBucketModel {
    let repoName: String
    let repoDescription: String
    let userName: String
    let avatarUrl: String
}

struct BitBucketMapper {
    static func map(_ model: BitBucketResponseModel) -> BitBucketModel {
        return BitBucketModel(repoName: model.values.first?.repoName ?? "",
                              repoDescription: model.values.first?.repoDescription ?? "",
                              userName: model.values.first?.bitbucketOwner.userName ?? "",
                              avatarUrl: model.values.first?.bitbucketOwner.links.avatarURL.href ?? "")
    }
}
