//
//  WishStoringViewController.swift
//  ddshoshina@edu.hse.ru
//
//  Created by Диана on 10/11/2025.
//

import UIKit
import CoreData

// the table screen
final class WishStoringViewController: UIViewController {
    private let table: UITableView = UITableView(frame: .zero)
    private var wishArray: [Wish] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        loadWishes()
        configureTable()
      
    }
    enum Constants {
        static let tableCornerRadius: CGFloat = 20
        static let tableOffset: CGFloat = 20
        
        static let sectionsCount: Int = 2
        
        static let addWishSection: Int = 0
        static let writtenWishesSection: Int = 1
        
        static let wishesKey: String = "wishesKey"
    }
    private func configureTable() {
        view.addSubview(table)
        table.backgroundColor = .red
        table.dataSource = self
        
        table.delegate = self
        
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
            
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
        
        table.pin(to: view, Constants.tableOffset)
    }
    private func loadWishes() {
        wishArray = CoreDataManager.shared.fetchWishes()
    }

}



extension WishStoringViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.sectionsCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Constants.addWishSection:
            return 1
        case Constants.writtenWishesSection:
            return wishArray.count
        default:
            return 0
        
        }
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            
        case Constants.addWishSection:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: AddWishCell.reuseId,
                for: indexPath
            ) as? AddWishCell else {
                return UITableViewCell()
            }


            cell.addWish = { [weak self] newText in
                guard let self = self else { return }
                let newWish = CoreDataManager.shared.addWish(text: newText)
                self.wishArray.append(newWish)
                self.table.reloadData()
            }

            return cell
            
        case Constants.writtenWishesSection:
            _ = tableView.dequeueReusableCell(
                withIdentifier: WrittenWishCell.reuseId,
                for: indexPath
            )
            guard let wishCell = tableView.dequeueReusableCell(
                    withIdentifier: WrittenWishCell.reuseId,
                    for: indexPath
                ) as? WrittenWishCell else {
                    return UITableViewCell()
                }

                let wish = wishArray[indexPath.row]
                wishCell.configure(with: wish.text ?? "")
                return wishCell
            
        default:
            return UITableViewCell()
            
        }
    
        
    }
}

extension WishStoringViewController: UITableViewDelegate {

    // strings what are free to edit
    func tableView(_ tableView: UITableView,
                   canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == Constants.writtenWishesSection
    }

    // share + delete
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {

        guard indexPath.section == Constants.writtenWishesSection else {
            return nil
        }

        let wish = wishArray[indexPath.row]

        //Share
        let shareAction = UIContextualAction(style: .normal,
                                             title: "Share") { [weak self] _, _, completion in
            guard let self = self else { return }
            let text = wish.text ?? ""

            // system sharing screen
            let activityVC = UIActivityViewController(
                activityItems: [text],
                applicationActivities: nil
            )
            if let popover = activityVC.popoverPresentationController {
                popover.sourceView = self.view
                popover.sourceRect = tableView.rectForRow(at: indexPath)
            }

            self.present(activityVC, animated: true)
            completion(true)
        }
        shareAction.backgroundColor = .systemBlue

        //Delete
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: "Delete") { [weak self] _, _, completion in
            guard let self = self else { return }

            CoreDataManager.shared.deleteWish(wish)
            self.wishArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)

            completion(true)
        }

        //what to do first when swipe
        return UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
    }

    // what to do when tap (edit wish)
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {

        guard indexPath.section == Constants.writtenWishesSection else { return }
        let wish = wishArray[indexPath.row]
        let currentText = wish.text ?? ""

        // alert with text field configure
        let alert = UIAlertController(
            title: "Edit wish",
            message: nil,
            preferredStyle: .alert
        )
        alert.addTextField { textField in
            textField.text = currentText
            textField.placeholder = "Enter wish"
        }

        // cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            tableView.deselectRow(at: indexPath, animated: true)
        }

        // save button
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self, weak alert] _ in
            guard
                let self = self,
                let textField = alert?.textFields?.first
            else { return }

            let newText = textField.text?
                .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

            guard !newText.isEmpty else {
                tableView.deselectRow(at: indexPath, animated: true)
                return
            }
            // save new text
            CoreDataManager.shared.updateWish(wish, newText: newText)
            tableView.reloadRows(at: [indexPath], with: .automatic)
            tableView.deselectRow(at: indexPath, animated: true)
        }

        alert.addAction(cancelAction)
        alert.addAction(saveAction)

        present(alert, animated: true, completion: nil)
    }
}
