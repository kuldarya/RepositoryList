//
//  APIRouter.swift
//  ListOfElements
//
//  Created by Darya Kuliashova on 18.03.21.
//

import Foundation

enum APIRouter: Router {
    case getBitbucketElements
    case getGithubElements
    
    var path: String {
        switch self {
        case .getBitbucketElements:
            return "https://api.bitbucket.org/2.0/repositories?fields=values.name,values.owner,values.description"
        case .getGithubElements:
            return "https://api.github.com/repositories"
        }
    }
    
    func asURL() -> URL {
        if let url = URL(string: path) {
            return url
        } else {
            fatalError("URL can't be nil.")
        }
    }
}
