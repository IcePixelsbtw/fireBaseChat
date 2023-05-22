//
//  LoginViewController.swift
//  fireBaseChat
//
//  Created by Anton on 09.05.2023.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    //MARK: - Initialize views
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.clipsToBounds = true
        
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.layer.borderColor = CGColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
        field.placeholder = "Email Adress..."
        field.backgroundColor = .white
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password..."
        field.backgroundColor = .white
        field.layer.borderColor = CGColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.isSecureTextEntry = true
        
        return field
    }()
    
    private let logInButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Log In -->", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.link, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.borderColor = CGColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
        return button
        
        
    }()
    
    private let facebookLoginButton: FBLoginButton = {
        let button = FBLoginButton()
        
        button.permissions = ["email", "public_profile"]
        
        return button
        
        
    }()
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let backgroundLayer = Colors.shared.gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
        title = "Log in"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
        
        
        logInButton.addTarget(self,
                              action: #selector(didTapLogIn),
                              for: .touchUpInside)
        
        emailField.delegate = self
        passwordField.delegate = self
        facebookLoginButton.delegate = self
        
        
        //MARK: Add subviews
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(logInButton)
        scrollView.addSubview(facebookLoginButton)
        
    }
    
    //MARK: - Layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        let size = scrollView.width / 3
        imageView.frame = CGRect(x: (scrollView.width - size) / 2,
                                 y: 30,
                                 width: size,
                                 height: size)
        emailField.frame = CGRect(x: 30,
                                  y: imageView.bottom + 10,
                                  width: scrollView.width - 60,
                                  height: 52)
        passwordField.frame = CGRect(x: 30,
                                     y: emailField.bottom + 10,
                                     width: scrollView.width - 60,
                                     height: 52)
        logInButton.frame = CGRect(x: 30,
                                   y: passwordField.bottom + 10,
                                   width: scrollView.width - 60,
                                   height: 52)
        facebookLoginButton .frame = CGRect(x: 30,
                                            y: logInButton.bottom + 10,
                                            width: scrollView.width - 60,
                                            height: 52)
        
        facebookLoginButton.frame.origin.y = logInButton.bottom + 20
    }
    
    
    //MARK: Functions
    //MARK: - Log in button function
    @objc private func didTapLogIn() {
        
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text, let password = passwordField.text, !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            
            alertUserLogInError()
            return
        }
        
        //MARK:  Firebase log in
        FirebaseAuth.Auth.auth().signIn(withEmail: email,
                                        password: password,
                                        completion: { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            guard let result = authResult, error == nil else {
                print("Error while signing in...")
                return
            }
            let user = result.user
            print("Logged in User: \(user)")
            strongSelf.navigationController?.dismiss(animated: true,
                                                     completion: nil)
            
        })
    }
    
    
    //MARK: - Alert error during log in
    func alertUserLogInError() {
        let alert = UIAlertController(title: "Whoops...",
                                      message: "Something went wrong, please make sure that both email and password are filled in. Also make sure that password is more than 6 symbols long",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Got it!",
                                      style: .cancel,
                                      handler: nil))
        
        present(alert, animated: true)
    }
    
    //MARK: - Register button function
    @objc private func didTapRegister() {
        let vc = RegisterViewController()
        vc.title = "Create account"
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: -  Extensions
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            didTapLogIn()
        }
        
        return true
    }
}

extension LoginViewController: LoginButtonDelegate {
    
    func loginButton(_ loginButton: FBSDKLoginKit.FBLoginButton, didCompleteWith result: FBSDKLoginKit.LoginManagerLoginResult?, error: Error?) {
        
        //MARK: Unwrap a token from Facebook
        guard let token = result?.token?.tokenString else {
            print("User faield to log in with Facebook...")
            return
        }
        
        //MARK: Make a request to get data about the user
        let facebookRequest = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                         parameters: ["fields" : "email, name"],
                                                         tokenString: token,
                                                         version: nil,
                                                         httpMethod: .get)
        
        //MARK: Execute a request
        facebookRequest.start(completion: { _, result, error in
             
            guard let result = result as? [String: Any],
                  error == nil else {
                print("Failed to make facebook graph request...")
                return
            }
            
            print("\(result)")
            
            guard let userName = result["name"] as? String,
                  let email = result["email"] as? String else {
                print("Failed to get email and name from FBResults...")
                return
            }
            
            let nameComponents = userName.components(separatedBy: " ")
            
            guard nameComponents.count == 2 else {
                return
            }
            
            let firstName = nameComponents[0]
            let lastName = nameComponents[1]
            
            //MARK: Checking if user is already exists
            
            DatabaseManager.shared.userExists(with: email, completion: { exists in
                if !exists {
                    DatabaseManager.shared.insertUser(with: ChatAppUser(firstName: firstName,
                                                                        lastName: lastName,
                                                                        emailAddress: email))
                }
                
                
            })
            
            //MARK: Signing in via Firabase using Facebook credentials
            let credential = FacebookAuthProvider.credential(withAccessToken: token)
            FirebaseAuth.Auth.auth().signIn(with: credential,
                                            completion: { [weak self] authResult, error in
                guard authResult != nil, error == nil else {
                    print("Facebook credential log in failed...")
                    print("MFA may be needed...")
                    return
                }
                guard let strongSelf = self else {
                    return
                }
                print("Succesfully logged in via Facebook...")
                strongSelf.navigationController?.dismiss(animated: true,
                                                         completion: nil)
            })
        })
        
        
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginKit.FBLoginButton) {
        // no operation
    }
    
    
    
}
