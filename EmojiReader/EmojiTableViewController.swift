//
//  EmojiTableViewController.swift
//  EmojiReader
//
//  Created by sergey on 04.07.2021.
//

import UIKit

class EmojiTableViewController: UITableViewController {

    var objects = [
        Emoji(emoji: "🥰", name: "Love", description: "Lets love", isFavourit: true),
        Emoji(emoji: "😎", name: "Fucking", description: "Fuck all", isFavourit: false),
        Emoji(emoji: "😇", name: "Angel", description: "My love is angel", isFavourit: false)
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.title = "Emoji Reader"
       
    }

    @IBAction func unwindSegeue(segue: UIStoryboardSegue){
        guard segue.identifier == "saveSegeu" else { return }
        guard tableView.indexPathForSelectedRow == nil else { return }
        let sourceVC = segue.source as! NewEmojiTableViewController
        let emoji = sourceVC.baseEmoji
        
        objects.append(emoji)
        tableView.insertRows(at: [IndexPath(row: objects.count-1, section: 0)], with: .automatic)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editEmoji" else { return }
        let indexPath = tableView.indexPathForSelectedRow
        let emoji = objects[indexPath!.row]
        let navigaionVC = segue.destination as! UINavigationController
        let newEmojiCV = navigaionVC.topViewController as! NewEmojiTableViewController
        newEmojiCV.baseEmoji = emoji
        newEmojiCV.title = "Edit"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objects.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath) as! EmojiTableViewCell
        cell.set(obj: objects[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .middle)
        }
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoji = objects.remove(at: sourceIndexPath.row)
        objects.insert(movedEmoji, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = doneAction(to: indexPath)
        let favorit = favoritAction(to: indexPath)
        return UISwipeActionsConfiguration(actions: [action, favorit])
    }
    
    func doneAction(to indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Done") { [weak self](action, view, complection) in
            self?.objects.remove(at: indexPath.row)
            self?.tableView.deleteRows(at: [indexPath], with: .automatic)
            complection(true)
        }
        action.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        action.image = UIImage(systemName: "checkmark,circle")
        return action
    }
    
    func favoritAction(to indexPath: IndexPath) -> UIContextualAction {
        var object = objects[indexPath.row]
        let action = UIContextualAction(style: .destructive, title: "favorit") { [weak self](action, view, complection) in
            object.isFavourit = !object.isFavourit
            self?.objects[indexPath.row] = object
            complection(true)
        }
        action.backgroundColor = object.isFavourit ? #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1) : #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        action.image = UIImage(systemName: "heart")
        return action
    }
}
