//
//  RegisterViewController.swift
//  FirebaseLoginChat
//
//  Created by Pedro Ésli Vieira do Nascimento on 16/03/23.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    private let cadastrarFirebaseLabel: UILabel = {
        let label = UILabel()
        label.text = "Cadastrar"
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
    
    private let senhaLabel: UILabel = {
        let label = UILabel()
        label.text = "Senha"
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
    
    private lazy var senhaTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Digite sua senha"
        textfield.font = UIFont.preferredFont(forTextStyle: .body)
        textfield.textContentType = .newPassword
        textfield.isSecureTextEntry = true
        textfield.borderStyle = .roundedRect
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        var title = AttributedString("Cadastrar")
        title.font = UIFont.preferredFont(forTextStyle: .title3)
        config.buttonSize = .medium
        config.attributedTitle = title
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)

        view.addSubview(cadastrarFirebaseLabel)
        view.addSubview(userNameLabel)
        view.addSubview(userNameTextField)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(senhaLabel)
        view.addSubview(senhaTextField)
        view.addSubview(registerButton)
        
        configureConstraints()
    }
    
    func configureConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            cadastrarFirebaseLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            cadastrarFirebaseLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            cadastrarFirebaseLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            userNameLabel.topAnchor.constraint(equalTo: cadastrarFirebaseLabel.bottomAnchor, constant: 30),
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
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            senhaLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            senhaLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            senhaLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            
            senhaTextField.topAnchor.constraint(equalTo: senhaLabel.bottomAnchor, constant: 8),
            senhaTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            senhaTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            senhaTextField.heightAnchor.constraint(equalToConstant: 50),
            
            registerButton.topAnchor.constraint(equalTo: senhaTextField.bottomAnchor, constant: 20),
            registerButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            registerButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16)
        ])
    }
    
    @objc func registerButtonPressed() {
        guard let email = emailTextField.text, let password = senhaTextField.text, let name = userNameTextField.text else {
            self.showAlert(title: "Inválido", message: "Email ou senha não podem ser vazios.")
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error {
                self.showAlert(title: "Erro", message: "Não foi possível criar conta!")
                print("Error trying to create user account: \(error.localizedDescription)")
                return
            }
            
            guard let user = authResult?.user else { return }
            
            user.sendEmailVerification { error in
                if let error {
                    print("Error at seding email verification: \(error.localizedDescription)")
                }
            }
            
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = name
            changeRequest.commitChanges { error in
                if let error {
                    print("Error at commiting changes: \(error.localizedDescription)")
                }
            }
            
            self.showAlert(title: "Sucesso", message: "Conta criada com sucesso!") {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
