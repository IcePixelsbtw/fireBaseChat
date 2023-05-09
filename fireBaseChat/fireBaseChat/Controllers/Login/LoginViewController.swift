//
//  LoginViewController.swift
//  fireBaseChat
//
//  Created by Anton on 09.05.2023.
//

import UIKit

class LoginViewController: UIViewController {

    private var imageView: UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "system.message.fill")
        imageView.tintColor = .link
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        title = "Log in"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
     
        
        view.addSubview(imageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let size = view.frame.size.width / 3
        imageView.frame = CGRect(x: (view.frame.size.width - size) / 2,
                                 y: 20,
                                 width: size,
                                 height: size)
    }


@objc private func didTapRegister() {
    let vc = RegisterViewController()
    vc.title = "Create account"
    navigationController?.pushViewController(vc, animated: true)
        }

}
