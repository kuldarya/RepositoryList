//
//  ElementDetailsViewController.swift
//  RepositoryList
//
//  Created by Darya Kuliashova on 21.03.21.
//

import UIKit

class ElementDetailsViewController: UIViewController {
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userAvatar: UIImageView!
    
    var element: ElementType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
