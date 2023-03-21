//
//  SwitchCell.swift
//  FirebaseLoginChat
//
//  Created by Pedro Ésli Vieira do Nascimento on 20/03/23.
//

import UIKit

class SwitchCell: SettingCell {
    let text: String
    let id: String
    let action: (_ isOn: Bool) -> Void
    
    lazy var uiSwitch = UISwitch()
    
    init(text: String, id: String, isOn: Bool = false, action: @escaping (_ isOn: Bool) -> Void ) {
        self.text = text
        self.id = id
        self.action = action
        self.uiSwitch.isOn = isOn
        self.uiSwitch.addTarget(self, action: #selector(switchStateDidChange(_:)), for: .valueChanged)
    }
    
    func cellConfiguration(tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = text
        cell.contentConfiguration = content
        cell.accessoryView = uiSwitch
        return cell
    }
    
    func cellPrimaryAction() {
        
    }
    
    @objc func switchStateDidChange(_ sender: UISwitch) {
        action(sender.isOn)
    }
}
