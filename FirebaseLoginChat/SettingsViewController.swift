//
//  SettingsViewController.swift
//  FirebaseLoginChat
//
//  Created by Pedro Ésli Vieira do Nascimento on 17/03/23.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    lazy var tableView: UITableView = {
        var tableView = UITableView(frame: .null, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "settingCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var settingOptions = [SettingCell]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        title = "Configuração"
        
        settingOptions = settingOptionsSource()
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        configureConstraints()
    }
    
    func configureConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    func settingOptionsSource() -> [SettingCell] {
        var settingOptions = [SettingCell]()
        settingOptions.append(NavigationCell(text: "Validar email", id: "validarEmail", action: navigationPressed(id:)))
        settingOptions.append(ButtonCell(text: "Finalizar sessão",textColor: .systemBlue, action: signOutPressed))
        settingOptions.append(ButtonCell(text: "Remover conta!", textColor: .red, action: deletePressed))
        return settingOptions
    }
    
    func navigationPressed(id: String) {
        if id == "validarEmail" {
            self.navigationController?.pushViewController(EmailVerifyViewController(), animated: true)
        }
    }
    
    func signOutPressed() {
        do {
            try Auth.auth().signOut()
            self.navigationController?.popToRootViewController(animated: true)
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    func deletePressed() {
        self.showDeleteAlert(title: "Cuidado!", message: "Tem certeza que deseja remover a sua conta?") {
            Auth.auth().currentUser?.delete(completion: { error in
                if let error = error as? NSError {
                    let errorCode = AuthErrorCode(_nsError: error)
                    if errorCode.code == .requiresRecentLogin {
                        let loginView = LoginViewController()
                        loginView.isReauthenticationLogin = true
                        loginView.reauthenticationAction = self.retryDelete
                        self.present(loginView, animated: true)
                    } else {
                        print("Error deleting user: \(error.localizedDescription)")
                        return
                    }
                }
                
                self.showAlert(title: "Conta removida", message: "A sua conta foi removida com successo") {
                    try! Auth.auth().signOut()
                    self.navigationController?.popToRootViewController(animated: true)
                }
            })
        }
    }
    
    func retryDelete() {
        Auth.auth().currentUser?.delete(completion: { error in
            if let error {
                print("Error deleting user: \(error.localizedDescription)")
                return
            }
            
            self.showAlert(title: "Conta removida", message: "A sua conta foi removida com successo") {
                try! Auth.auth().signOut()
                self.navigationController?.popToRootViewController(animated: true)
            }
        })
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return settingOptions[indexPath.row].cellConfiguration(tableView: tableView, for: indexPath)
    }
}

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, canPerformPrimaryActionForRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, performPrimaryActionForRowAt indexPath: IndexPath) {
        settingOptions[indexPath.row].cellPrimaryAction()
    }
}
