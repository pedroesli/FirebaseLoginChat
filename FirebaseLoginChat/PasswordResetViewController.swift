//
//  PasswordResetViewController.swift
//  FirebaseLoginChat
//
//  Created by Pedro Ésli Vieira do Nascimento on 23/03/23.
//

import UIKit
import FirebaseAuth

class PasswordResetViewController: UIViewController {

    private lazy var titleLable: UILabel = {
        let lable = UILabel()
        lable.text = "Problemas para entrar?"
        lable.font = UIFont.preferredFont(forTextStyle: .title1, weight: .bold)
        lable.textAlignment = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private lazy var informationLable: UILabel = {
        let lable = UILabel()
        lable.text = "Insira o seu email e enviaremos um link para você voltar a acessar a sua conta."
        lable.font = UIFont.preferredFont(forTextStyle: .callout)
        lable.textAlignment = .center
        lable.numberOfLines = 0
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
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
    
    private lazy var sendButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        var title = AttributedString("Enviar link")
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
        
        sendButton.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
        
        view.addSubview(titleLable)
        view.addSubview(informationLable)
        view.addSubview(emailTextField)
        view.addSubview(sendButton)
        
        configureConstraints()
    }

    func configureConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            titleLable.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
            titleLable.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            titleLable.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            informationLable.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 16),
            informationLable.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            informationLable.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            
            emailTextField.topAnchor.constraint(equalTo: informationLable.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            
            sendButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40),
            sendButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            sendButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
        ])
    }
    
    @objc func sendButtonPressed() {
        guard let email = emailTextField.text else { return }
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error {
                print("Send password reset error: \(error.localizedDescription)")
                return
            }
            
            self.showAlert(title: "Enviado!", message: "Email enviado com sucesso!") {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
