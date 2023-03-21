//
//  ButtonCell.swift
//  FirebaseLoginChat
//
//  Created by Pedro Ésli Vieira do Nascimento on 20/03/23.
//

import UIKit

struct ButtonCell: SettingCell {
    let text: String
    var textColor: UIColor = .label
    let action: () -> Void
    
    func cellConfiguration(tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = text
        content.textProperties.color = textColor
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        return cell
    }
    
    func cellPrimaryAction() {
        action()
    }
}
