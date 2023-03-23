//
//  EmailVerifyViewController.swift
//  FirebaseLoginChat
//
//  Created by Pedro Ésli Vieira do Nascimento on 21/03/23.
//

import UIKit
import FirebaseAuth

class EmailVerifyViewController: UIViewController {
    
    private lazy var emailStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Email não verificado!"
        label.textColor = .systemRed
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var sendVerificationButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.buttonSize = .small
        button.configuration = config
        button.setTitle("Enviar verificação", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        if let user = Auth.auth().currentUser, user.isEmailVerified {
            emailStatusLabel.text = "Email verificado!"
            emailStatusLabel.textColor = .systemGreen
            sendVerificationButton.isEnabled = false
        }
        view.addSubview(emailStatusLabel)
        view.addSubview(sendVerificationButton)
        
        configureConstraints()
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            emailStatusLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            emailStatusLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            emailStatusLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            sendVerificationButton.topAnchor.constraint(equalTo: emailStatusLabel.bottomAnchor, constant: 16),
            sendVerificationButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            sendVerificationButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -8),
        ])
    }

}
