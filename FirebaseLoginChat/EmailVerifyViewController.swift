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
    
    private lazy var verifyStatusButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.title = "Verifical status"
        config.image = UIImage(systemName: "arrow.triangle.2.circlepath")
        config.imagePlacement = .trailing
        config.buttonSize = .small
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        sendVerificationButton.addTarget(self, action: #selector(sendVerificationButtonPressed), for: .touchUpInside)
        verifyStatusButton.addTarget(self, action: #selector(verifyStatusButtonPressed), for: .touchUpInside)
        
        checkUserEmailVerified(user: Auth.auth().currentUser)
        
        view.addSubview(emailStatusLabel)
        view.addSubview(sendVerificationButton)
        view.addSubview(verifyStatusButton)
        
        configureConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            emailStatusLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            emailStatusLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            emailStatusLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            sendVerificationButton.topAnchor.constraint(equalTo: emailStatusLabel.bottomAnchor, constant: 16),
            sendVerificationButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            sendVerificationButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -8),
            
            verifyStatusButton.topAnchor.constraint(equalTo: sendVerificationButton.bottomAnchor, constant: 16),
            verifyStatusButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            verifyStatusButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -8),
        ])
    }
    
    func checkUserEmailVerified(user: User?) {
        guard let user, user.isEmailVerified else { return }
        
        emailStatusLabel.text = "Email verificado!"
        emailStatusLabel.textColor = .systemGreen
        sendVerificationButton.isHidden = true
        verifyStatusButton.isHidden = true
    }
    
    @objc func sendVerificationButtonPressed() {
        Auth.auth().currentUser?.sendEmailVerification { error in
            print("Error sending email verification")
        }
    }
    
    @objc func verifyStatusButtonPressed() {
        Auth.auth().currentUser?.reload { error in
            if let error {
                print("Error reloading user: \(error.localizedDescription)")
                return
            }
            
            self.checkUserEmailVerified(user: Auth.auth().currentUser)
        }
    }
}
