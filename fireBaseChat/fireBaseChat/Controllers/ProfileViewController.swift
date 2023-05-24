//
//  ProfileViewController.swift
//  fireBaseChat
//
//  Created by Anton on 09.05.2023.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn

class ProfileViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    let data = ["Log Out"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
}



extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .red
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let actionSheet = UIAlertController(title: "Log out?",
                                            message: "Are you sure you want to log out?",
                                            preferredStyle: .alert)
        actionSheet.addAction(UIAlertAction(title: "Yes",
                                            style: .destructive,
                                            handler: { [weak self] _ in
            guard let strongSelf = self else {
                return
            }
            
            //Log out facebook
            
            FBSDKLoginKit.LoginManager().logOut()
            
            //Log out Google
            
            GIDSignIn.sharedInstance.signOut()
            
            do {
                try FirebaseAuth.Auth.auth().signOut()
                print("Log out succesfull")
                
                let vc = LoginViewController()
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                strongSelf.present(nav, animated: true)
                
                
            } catch {
                print("Failed to log out...")
            }
            
        }))
        actionSheet.addAction(UIAlertAction(title: "No",
                                            style: .default,
                                            handler: { _ in
            actionSheet.dismiss(animated: true)
        } ))
        present(actionSheet, animated: true)
    }
    
}
