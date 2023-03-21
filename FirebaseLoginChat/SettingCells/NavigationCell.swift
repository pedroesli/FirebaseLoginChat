//
//  NavigationCell.swift
//  FirebaseLoginChat
//
//  Created by Pedro Ésli Vieira do Nascimento on 20/03/23.
//

import UIKit

struct NavigationCell: SettingCell {

    let text: String
    let id: String
    let action: (_ id: String) -> Void
    
    func cellConfiguration(tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        var content = cell.defaultContentConfiguration()
        content.text = text
        cell.contentConfiguration = content
        return cell
    }
    
    func cellPrimaryAction() {
        action(id)
    }
}
