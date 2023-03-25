//
//  MainViewController.swift
//  FirebaseLoginChat
//
//  Created by Pedro Ésli Vieira do Nascimento on 16/03/23.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Hello, \(Auth.auth().currentUser?.displayName ?? "Anonymous")"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        navigationItem.backButtonTitle = "Voltar"
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gearshape.fill"),
            style: .plain,
            target: self,
            action: #selector(settingsButtonPressed)
        )
        
        NotificationCenter.default.addObserver(self, selector: #selector(displayNameChanged), name: NSNotification.Name("com.user.changed.displayname"), object: nil)
    }
    
    @objc func settingsButtonPressed() {
        self.navigationController?.pushViewController(SettingsViewController(), animated: true)
    }
    
    @objc func displayNameChanged() {
        title = "Hello, \(Auth.auth().currentUser?.displayName ?? "Anonymous")"
    }
}
