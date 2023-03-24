//
//  UIViewController+Extensions.swift
//  FirebaseLoginChat
//
//  Created by Pedro Ésli Vieira do Nascimento on 16/03/23.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, handler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            handler?()
        }))
        self.present(alert, animated: true)
    }
    
    func showDeleteAlert(title: String, message: String, deleteAction: @escaping () -> Void ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        alert.addAction(UIAlertAction(title: "Remover", style: .destructive, handler: { action in
            deleteAction()
        }))
        self.present(alert, animated: true)
    }
}
