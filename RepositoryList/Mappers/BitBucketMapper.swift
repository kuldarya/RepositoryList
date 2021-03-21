//
//  BitBucketMapper.swift
//  RepositoryList
//
//  Created by Darya Kuliashova on 21.03.21.
//

import Foundation

struct BitBucketMapper {
    func map(_ model: BitBucketElementResponseModel) -> BitBucketModel {
        BitBucketModel(
            repoName: model.repoName,
            repoDescription: model.repoDescription,
            userName: model.bitbucketOwner.userName,
            avatarUrl: model.bitbucketOwner.links.avatarURL.href
        )
    }
}
