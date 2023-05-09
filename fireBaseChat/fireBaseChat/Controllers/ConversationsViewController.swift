//
//  ViewController.swift
//  fireBaseChat
//
//  Created by Anton on 08.05.2023.
//

import UIKit

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    
        if !isLoggedIn {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }

}

