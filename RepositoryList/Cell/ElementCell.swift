//
//  ElementCell.swift
//  RepositoryList
//
//  Created by Darya Kuliashova on 21.03.21.
//

import UIKit

class ElementCell: UITableViewCell {
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var element: ElementType? {
        didSet {
            switch element {
            case .bitbucket(let bitbucket):
                repoNameLabel.text = bitbucket.repoName
                userNameLabel.text = bitbucket.userName
                
                guard let bitbucketURL = URL(string: bitbucket.avatarUrl) else { return }
                avatarImageView.load(url: bitbucketURL)
                
            case .github(let github):
                repoNameLabel.text = github.repoName
                userNameLabel.text = github.userName
                
                guard let githubURL = URL(string: github.avatarUrl) else { return }
                avatarImageView.load(url: githubURL)
                
            default:
                return
            }
        }
    }
}


