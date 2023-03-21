//
//  MainViewController.swift
//  FirebaseLoginChat
//
//  Created by Pedro Ésli Vieira do Nascimento on 15/03/23.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    private let firebaseLogo: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "FirebaseLogo")
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let loginFirebaseLabel: UILabel = {
        let label = UILabel()
        label.text = "Login Firebase"
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textAlignment = .center
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
        textfield.textContentType = .password
        textfield.isSecureTextEntry = true
        textfield.borderStyle = .roundedRect
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        var title = AttributedString("Login")
        title.font = UIFont.preferredFont(forTextStyle: .title3)
        config.buttonSize = .medium
        config.attributedTitle = title
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var newAccountButton: UIButton = {
        let button = UIButton()
        button.configuration = UIButton.Configuration.plain()
        button.configuration?.title = "Não tem conta? Cadastre-se"
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if Auth.auth().currentUser != nil {
            self.navigationController?.pushViewController(MainViewController(), animated: false)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationItem.backButtonTitle = "Voltar"
        
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        newAccountButton.addTarget(self, action: #selector(newAccountButtonPressed), for: .touchUpInside)
        
        view.addSubview(firebaseLogo)
        view.addSubview(loginFirebaseLabel)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(senhaLabel)
        view.addSubview(senhaTextField)
        view.addSubview(loginButton)
        view.addSubview(newAccountButton)
        configureConstraints()
    }
    
    func configureConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            firebaseLogo.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: -10),
            firebaseLogo.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 100),
            firebaseLogo.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -100),
            firebaseLogo.heightAnchor.constraint(equalToConstant: 150),
            
            loginFirebaseLabel.topAnchor.constraint(equalTo: firebaseLogo.bottomAnchor, constant: 20),
            loginFirebaseLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            loginFirebaseLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: loginFirebaseLabel.bottomAnchor, constant: 30),
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
            
            loginButton.topAnchor.constraint(equalTo: senhaTextField.bottomAnchor, constant: 40),
            loginButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            
            newAccountButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            newAccountButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            newAccountButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16)
        ])
    }
    
    @objc func loginButtonPressed() {
        guard let email = emailTextField.text, let password = senhaTextField.text else {
            self.showAlert(title: "Inválido", message: "Email ou senha não podem ser vazios.")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            if let error {
                strongSelf.showAlert(title: "Erro", message: "Não foi possível fazer login!")
                print("Erro ao fazer login: \(error.localizedDescription)")
                return
            }
            
            strongSelf.navigationController?.pushViewController(MainViewController(), animated: true)
        }
    }
    
    @objc func newAccountButtonPressed() {
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
}
