//
//  SettingCell.swift
//  FirebaseLoginChat
//
//  Created by Pedro Ésli Vieira do Nascimento on 20/03/23.
//

import UIKit

protocol SettingCell {
    func cellConfiguration(tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell
    func cellPrimaryAction()
}
