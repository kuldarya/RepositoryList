//
//  ElementsViewModel.swift
//  RepositoryList
//
//  Created by Darya Kuliashova on 21.03.21.
//

import Foundation

struct ElementsViewModel {
    let elements: [ElementType]
}

extension ElementsViewModel {
    static var empty: Self {
        ElementsViewModel(elements: [])
    }
}
