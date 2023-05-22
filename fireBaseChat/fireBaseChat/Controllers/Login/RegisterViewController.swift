//
//  LoginViewController.swift
//  fireBaseChat
//
//  Created by Anton on 09.05.2023.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    //MARK: - Initialize views
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.clipsToBounds = true
        
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(systemName: "person.circle")
        imageView.tintColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        
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
    
    private let firstNameField: UITextField = {
        let field = UITextField()
        
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.layer.borderColor = CGColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
        field.placeholder = "Enter your first name"
        field.backgroundColor = .white
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        
        return field
    }()
    
    private let lastNameField: UITextField = {
        let field = UITextField()
        
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.layer.borderColor = CGColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
        field.placeholder = "Enter your last name"
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
        field.placeholder = "Enter your password"
        field.backgroundColor = .white
        field.layer.borderColor = CGColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
        
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.isSecureTextEntry = true
        
        return field
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Sign up", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.link, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.borderColor = CGColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1)
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        
        return button
        
        
    }()
    
    //MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let backgroundLayer = Colors.shared.gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
        title = "Sign up"
        
        
        signUpButton.addTarget(self,
                               action: #selector(didTapSignUp),
                               for: .touchUpInside)
        
        firstNameField.delegate = self
        lastNameField.delegate = self
        
        emailField.delegate = self
        passwordField.delegate = self
        
        
        //MARK: - Add subviews
        
        imageView.isUserInteractionEnabled = true
        scrollView.isUserInteractionEnabled = true
        
        view.addSubview(scrollView)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(signUpButton)
        
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(didTapChangeProfilePicture))
        
        
        imageView.addGestureRecognizer(gesture)
        
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
        
        imageView.layer.cornerRadius = imageView.width / 2.0
        
        firstNameField.frame = CGRect(x: 30,
                                      y: imageView.bottom + 10,
                                      width: scrollView.width - 60,
                                      height: 52)
        lastNameField.frame = CGRect(x: 30,
                                     y: firstNameField.bottom + 10,
                                     width: scrollView.width - 60,
                                     height: 52)
        emailField.frame = CGRect(x: 30,
                                  y: lastNameField.bottom + 10,
                                  width: scrollView.width - 60,
                                  height: 52)
        passwordField.frame = CGRect(x: 30,
                                     y: emailField.bottom + 10,
                                     width: scrollView.width - 60,
                                     height: 52)
        signUpButton.frame = CGRect(x: 30,
                                    y: passwordField.bottom + 10,
                                    width: scrollView.width - 60,
                                    height: 52)
        
    }
    
    //MARK: - Functions
    //MARK: Log in button function
    @objc private func didTapChangeProfilePicture() {
        
        presentPhotoActionSheet()
        print("Change picture called...")
    }
    
    @objc private func didTapSignUp() {
        
        print("Sign up called...")
        
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text,
              let password = passwordField.text,
              let firstName = firstNameField.text,
              let lastName = lastNameField.text,
              !firstName.isEmpty,
              !lastName.isEmpty,
              !email.isEmpty,
              !password.isEmpty,
              password.count >= 6 else {
            alertUserLogInError()
            return
        }
        
        //MARK: Firebase register
        
        DatabaseManager.shared.userExists(with: email, completion: { [weak self] exists in
            guard let strongSelf = self else {
                return
            }
            
            guard !exists else {
                strongSelf.alertUserLogInError(message: "Looks like a user with that email already exists.")
                return
            }
            FirebaseAuth.Auth.auth().createUser(withEmail: email,
                                                password: password,
                                                completion: { authResult, error in
                guard authResult != nil, error == nil else {
                    print("Error creating user...")
                    return
                }
                
                DatabaseManager.shared.insertUser(with: ChatAppUser(firstName: firstName,
                                                                    lastName: lastName,
                                                                    emailAddress: email))
                
                
                strongSelf.navigationController?.dismiss(animated: true,
                                                         completion: nil)
            })
            
        })
        
        
    }
    
    //MARK: - Alert error during registration
    func alertUserLogInError(message: String = "Please enter all information to proceed.") {
        let alert = UIAlertController(title: "Whoops...",
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Got it!",
                                      style: .cancel,
                                      handler: nil))
        
        present(alert, animated: true)
    }
}


//MARK: - Extensions
extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == firstNameField {
            lastNameField.becomeFirstResponder()
        } else if textField == lastNameField{
            emailField.becomeFirstResponder()
        }  else if textField == emailField{
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            didTapSignUp()
        }
        
        return true
    }
}


extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func presentPhotoActionSheet() {
        
        let actionSheet = UIAlertController(title: "Profile picture",
                                            message: "How would you like to take a picture?",
                                            preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel))
        actionSheet.addAction(UIAlertAction(title: "Take photo",
                                            style: .default,
                                            handler: { [weak self] _ in
            self?.presentCamera()
            
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose photo ",
                                            style: .default,
                                            handler: { [weak self] _ in
            
            self?.presentPhotoPicker()
            
        }))
        
        present(actionSheet, animated: true)
    }
    
    func presentCamera() {
        print("Present Camera called...")
        
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    func presentPhotoPicker() {
        print("Present Photo Picker called...")
        
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}
        
        self.imageView.image = selectedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
