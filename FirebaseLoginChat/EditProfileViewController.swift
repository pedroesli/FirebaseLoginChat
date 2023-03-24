//
//  EditProfileViewController.swift
//  FirebaseLoginChat
//
//  Created by Pedro Ésli Vieira do Nascimento on 23/03/23.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Nome"
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var userNameTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Digite seu nome"
        textfield.font = UIFont.preferredFont(forTextStyle: .body)
        textfield.textContentType = .name
        textfield.autocapitalizationType = .none
        textfield.borderStyle = .roundedRect
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var emailTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Digite seu email"
        textfield.font = UIFont.preferredFont(forTextStyle: .body)
        textfield.textContentType = .emailAddress
        textfield.autocapitalizationType = .none
        textfield.borderStyle = .roundedRect
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Salvar",
            style: .done,
            target: self,
            action: #selector(saveButtonPressed)
        )
        
        view.addSubview(userNameLabel)
        view.addSubview(userNameTextField)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        
        configureConstraints()
        initialValuesOfFields()
    }
    
    func configureConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16),
            userNameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            userNameLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            
            userNameTextField.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8),
            userNameTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            userNameTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            emailLabel.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 20),
            emailLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            emailLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            emailTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func initialValuesOfFields() {
        //guard let user =
    }
    
    @objc func saveButtonPressed() {
        
    }
}
